import 'package:app/core/constant.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:app/core/utils/app_shared_prefrence.dart';
import 'package:app/core/utils/ui_utils.dart';
import 'package:app/features/profile/data/models/social_media_link/social_media_links_request.dart';
import 'package:app/features/profile/domain/entities/provider_profile_social_links.dart';
import 'package:app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:app/features/profile/presentation/cubit/profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class SectionSocialLinks extends StatefulWidget {
  final ProfileCubit profileCubit;
  final int providerId;
  final List<ProviderProfileSocialLinks?>? listOfSoicalFromApi;
  final bool isApproved;
  const SectionSocialLinks(
      {required this.profileCubit,
        required this.listOfSoicalFromApi,
        required this.providerId,
        required this.isApproved,
        super.key});

  @override
  State<SectionSocialLinks> createState() => _SectionSocialLinksState();
}

class _SectionSocialLinksState extends State<SectionSocialLinks> {
  int? myid = serviceLocator
      .get<SharedPreferencesUtils>()
      .getData(key: CacheConstant.userId) as int?;

  @override
  Widget build(BuildContext context) {
    return myid != widget.providerId
        ? (widget.listOfSoicalFromApi!.isNotEmpty
        ? Expanded(
      child: ShowSocialLinksForUsers(
          listOfSocial: widget.listOfSoicalFromApi),
    )
        : const SizedBox())
        : Expanded(
        child: ShowSocialLinksForMyProfileWithOptions(
          profileCubit: widget.profileCubit,
          listOfSocialFromApi: widget.listOfSoicalFromApi,
          issAprrovid: widget.isApproved,
        ));
  }
}

class ShowSocialLinksForMyProfileWithOptions extends StatefulWidget {
  final List<ProviderProfileSocialLinks?>? listOfSocialFromApi;
  final ProfileCubit profileCubit;
  final bool issAprrovid;
  const ShowSocialLinksForMyProfileWithOptions(
      {required this.profileCubit,
        required this.listOfSocialFromApi,
        required this.issAprrovid,
        super.key });

  @override
  State<ShowSocialLinksForMyProfileWithOptions> createState() =>
      _ShowSocialLinksForMyProfileWithOptionsState();
}

class _ShowSocialLinksForMyProfileWithOptionsState
    extends State<ShowSocialLinksForMyProfileWithOptions> {
  List<String> localSocialListNotAvilable = [];
  final List<String> listOfAllSocialLocal = [
    "facebook",
    "instagram",
    "twitter",
    "linkedin"
  ];
  Widget getPlatformIcon(String platform) {
    switch (platform.toLowerCase()) {
      case 'twitter':
        return SvgPicture.asset(
          'asset/icons/social/twitter.svg',
          width: 20,
          height: 20,
        );
      case 'instagram':
        return SvgPicture.asset(
          'asset/icons/social/insta.svg',
          width: 20,
          height: 20,
        );
      case 'linkedin':
        return SvgPicture.asset(
          'asset/icons/social/linkedin.svg',
          width: 20,
          height: 20,
        );
      case 'facebook':
        return SvgPicture.asset(
          'asset/icons/social/facebook.svg',
          width: 20,
          height: 20,
        );
      case 'github':
        return SvgPicture.asset(
          'asset/icons/social/github.svg',
          width: 20,
          height: 20,
        );
      default:
        return const Icon(Icons.link, size: 20);
    }
  }
  @override
  void initState() {
    if (widget.listOfSocialFromApi!.isNotEmpty) {
      localSocialListNotAvilable = widget.listOfSocialFromApi!.map((e) {
        return e!.platform!;
      }).toList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Your social links',
              style: theme.textTheme.labelLarge,
            ),
            IconButton(
                onPressed: () {
                  List<String> listofSocialAvailable = [];

                  for (int i = 0; i < listOfAllSocialLocal.length; i++) {
                    if (!localSocialListNotAvilable
                        .contains(listOfAllSocialLocal[i])) {
                      listofSocialAvailable.add(listOfAllSocialLocal[i]);
                    }
                  }

                  showModalBottomSheet(
                    context: context,
                    isScrollControlled:
                    true, //  Important for keyboard to push content

                    shape: const RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (context) {
                      return SectionBodySheetAddLink(
                          listofSocialAvailable: listofSocialAvailable,
                          profileCubit: widget.profileCubit);
                    },
                  );
                },
                icon:  Icon(Icons.add,color: widget.issAprrovid?ColorManager.primary:ColorManager.textColor,))
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: Column(
            children: widget.listOfSocialFromApi!.map((e) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      getPlatformIcon(e!.platform!),
                      const SizedBox(width: 10),
                      Expanded(child: InkWell(
                        onTap: () {
                          _launchURL(e.url!);
                        },
                        child: SelectableText(
                          e.url!,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      )
                      ),
                      IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return SectionBodySheetEditLink(
                                      profileCubit: widget.profileCubit,
                                      platform: e.platform!,
                                      url: e.url!);
                                });
                          },
                          icon: const Icon(Icons.edit)),
                      BlocListener<ProfileCubit, ProfileStates>(
                          listener: (context, state) {
                            if (state is DeleteSocialLinkLoading) {
                              UIUtils.showLoadingDialog(context);
                            } else if (state is DeleteSocialLinkError) {
                              UIUtils.hideLoading(context);
                              UIUtils.showMessage(state.message);
                            } else if (state is DeleteSocialLinkSuccess) {
                              UIUtils.hideLoading(context);
                              UIUtils.showMessage(state.message);
                              widget.profileCubit.getUserRole();
                            }
                          },
                          child: IconButton(
                              onPressed: () {
                                widget.profileCubit.deleteSocialLinks(e.id!);
                              },
                              icon: const Icon(Icons.close)))
                    ],
                  ),
                  const SizedBox(height: 10)
                ],
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}

class ShowSocialLinksForUsers extends StatelessWidget {
  const ShowSocialLinksForUsers({
    super.key,
    required this.listOfSocial,
  });

  final List<ProviderProfileSocialLinks?>? listOfSocial;

  Widget getPlatformIcon(String platform) {
    switch (platform.toLowerCase()) {
      case 'twitter':
        return SvgPicture.asset(
          'asset/icons/social/twitter.svg',
          width: 20,
          height: 20,
        );
      case 'instagram':
        return SvgPicture.asset(
          'asset/icons/social/insta.svg',
          width: 20,
          height: 20,
        );
      case 'linkedin':
        return SvgPicture.asset(
          'asset/icons/social/linkedin.svg',
          width: 20,
          height: 20,
        );
      case 'facebook':
        return SvgPicture.asset(
          'asset/icons/social/facebook.svg',
          width: 20,
          height: 20,
        );
      case 'github':
        return SvgPicture.asset(
          'asset/icons/social/github.svg',
          width: 20,
          height: 20,
        );
      default:
        return const Icon(Icons.link, size: 20);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Social links',
          style: theme.textTheme.labelLarge,
        ),
        const SizedBox(height: 10),
        if (listOfSocial != null && listOfSocial!.isNotEmpty)
          ...listOfSocial!.map((e) {
            if (e == null) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getPlatformIcon(e.platform!),
                  Text(
                    e.platform!,
                    style: theme.textTheme.labelMedium,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [

                      const SizedBox(width: 8),
                      Expanded(
                        child: SelectableText(
                          e.url!,
                          maxLines: 1,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList()
        else
          Text('No social links available.', style: theme.textTheme.bodySmall),
      ],
    );
  }
}

class SectionBodySheetAddLink extends StatefulWidget {
  final List<String> listofSocialAvailable;
  final ProfileCubit profileCubit;

  const SectionBodySheetAddLink({
    required this.listofSocialAvailable,
    required this.profileCubit,
    super.key,
  });

  @override
  State<SectionBodySheetAddLink> createState() => _SectionBodySheetAddLinkState();
}

class _SectionBodySheetAddLinkState extends State<SectionBodySheetAddLink> {
  late Map<String, TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    controllers = {
      for (var platform in widget.listofSocialAvailable)
        platform: TextEditingController()
    };
  }

  @override
  void dispose() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Color getPlatformColor(String platform) {
    switch (platform.toLowerCase()) {
      case 'twitter':
        return const Color(0xFF1DA1F2);
      case 'instagram':
        return const Color(0xFFC13584);
      case 'linkedin':
        return const Color(0xFF0A66C2);
      case 'github':
        return const Color(0xFF333333);
      case 'facebook':
        return const Color(0xFF1877F2);
      default:
        return Colors.grey;
    }
  }

  Widget getPlatformIcon(String platform, double size) {
    String assetPath;

    switch (platform.toLowerCase()) {
      case 'twitter':
        assetPath = 'asset/icons/social/twitter.svg';
        break;
      case 'instagram':
        assetPath = 'asset/icons/social/insta.svg';
        break;
      case 'linkedin':
        assetPath = 'asset/icons/social/linkedin.svg';
        break;
      case 'facebook':
        assetPath = 'asset/icons/social/facebook.svg';
        break;
      case 'github':
        assetPath = 'asset/icons/social/github.svg';
        break;
      default:
        assetPath = 'asset/icons/social/linkedin.svg';
        break;
    }

    return SvgPicture.asset(
      assetPath,
      width: size,
      height: size,
    );
  }

  void onSave(String platform) {
    final link = controllers[platform]?.text ?? '';
    final platformLower = platform.toLowerCase();

    if (link.toLowerCase().contains(platformLower)) {
      widget.profileCubit.addOrupdateSoical(
        SocialMediaLinksRequest(platform: platform, url: link),
      );
    } else {
      UIUtils.showMessage("The URL does not match the platform.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileStates>(
      bloc: widget.profileCubit,
      listener: (context, state) {
        if (state is AddorUpdateSoicalLinksLoading) {
          UIUtils.showLoadingDialog(context);
        } else if (state is AddorUpdateSoicalLinksError) {
          UIUtils.hideLoading(context);
          UIUtils.showMessage(state.message);
        } else if (state is AddorUpdateSoicalLinksSuccess) {
          UIUtils.hideLoading(context);
          Navigator.of(context).pop();
          widget.profileCubit.getUserRole();
        }
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...widget.listofSocialAvailable.map((platform) {
                final color = getPlatformColor(platform);
                final controller = controllers[platform]!;

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: controller.text.isNotEmpty
                        ? color.withOpacity(0.15)
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      getPlatformIcon(platform, 24),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: controller,
                          decoration: InputDecoration(
                            hintText: "https://www.example.com",
                            border: InputBorder.none,
                            hintStyle: Theme.of(context).textTheme.labelMedium,
                          ),
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: controller.text.isNotEmpty
                                ? color.darken(0.2)
                                : Colors.black,
                          ),
                          onChanged: (_) => setState(() {}),
                        ),
                      ),
                      if (controller.text.isNotEmpty)
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.check, color: color),
                              onPressed: () => onSave(platform),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close, color: Colors.red),
                              onPressed: () {
                                controller.clear();
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                    ],
                  ),
                );
              }).toList(),
              ElevatedButton(
                onPressed: () {
                  widget.listofSocialAvailable.forEach(onSave);
                },
                child: const Text('Save All'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension ColorUtils on Color {
  Color darken([double amount = .1]) {
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
}



class SectionBodySheetEditLink extends StatefulWidget {
  final String url;
  final String platform;
  final ProfileCubit profileCubit;
  const SectionBodySheetEditLink(
      {required this.profileCubit,
        required this.platform,
        required this.url,
        super.key});

  @override
  State<SectionBodySheetEditLink> createState() =>
      _SectionBodySheetEditLinkState();
}

class _SectionBodySheetEditLinkState extends State<SectionBodySheetEditLink> {
  final TextEditingController urlText = TextEditingController();
  @override
  initState() {
    super.initState();
    urlText.text = widget.url;
  }

  @override
  dispose() {
    super.dispose();
    urlText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
            child: Column(
              children: [
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  autofocus: true,
                  controller: urlText,
                  decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: ColorManager.primary)),
                      fillColor: Colors.transparent,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: ColorManager.primary))),
                ),
                const SizedBox(height: 20),
                BlocListener<ProfileCubit, ProfileStates>(
                  listener: (context, state) {
                    if (state is AddorUpdateSoicalLinksLoading) {
                      UIUtils.showLoadingDialog(context);
                    } else if (state is AddorUpdateSoicalLinksError) {
                      UIUtils.hideLoading(context);
                      UIUtils.showMessage(state.message);
                    } else if (state is AddorUpdateSoicalLinksSuccess) {
                      UIUtils.hideLoading(context);
                      Navigator.of(context).pop();
                      widget.profileCubit.getUserRole();
                    }
                  },
                  child: ElevatedButton(
                      onPressed: () {
                        if (urlText.text.contains(widget.platform)) {
                          widget.profileCubit.addOrupdateSoical(
                              SocialMediaLinksRequest(
                                  platform: widget.platform,
                                  url: urlText.text));
                        }
                      },
                      child: const Text('Save')),
                ),
              ],
            ),
          ),
        ));
  }
}

Future<void> _launchURL(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}
