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

class SectionSocialLinks extends StatefulWidget {
  final ProfileCubit profileCubit;
  final int providerId;
  final List<ProviderProfileSocialLinks?>? listOfSoicalFromApi;
  const SectionSocialLinks(
      {required this.profileCubit,
      required this.listOfSoicalFromApi,
      required this.providerId,
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
                listOfSocialFromApi: widget.listOfSoicalFromApi));
  }
}

class ShowSocialLinksForMyProfileWithOptions extends StatefulWidget {
  final List<ProviderProfileSocialLinks?>? listOfSocialFromApi;
  final ProfileCubit profileCubit;
  const ShowSocialLinksForMyProfileWithOptions(
      {required this.profileCubit,
      required this.listOfSocialFromApi,
      super.key});

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
                icon: const Icon(Icons.add))
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: Column(
            children: widget.listOfSocialFromApi!.map((e) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e!.platform!,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(child: SelectableText(e.url!, maxLines: 1)),
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          'Your Social links',
          style: theme.textTheme.labelLarge,
        ),
        Expanded(
            child: Column(
          children: listOfSocial!.map((e) {
            return Column(
              children: [
                Text(
                  e!.platform!,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: 5),
                SelectableText(e.url!, maxLines: 1)
              ],
            );
          }).toList(),
        ))
      ],
    );
  }
}

class SectionBodySheetAddLink extends StatefulWidget {
  final List<String> listofSocialAvailable;
  final ProfileCubit profileCubit;
  const SectionBodySheetAddLink(
      {required this.listofSocialAvailable,
      required this.profileCubit,
      super.key});

  @override
  State<SectionBodySheetAddLink> createState() =>
      _SectionBodySheetAddLinkState();
}

class _SectionBodySheetAddLinkState extends State<SectionBodySheetAddLink> {
  TextEditingController textSelectedPlatform = TextEditingController();
  TextEditingController textSelectUrl = TextEditingController();

  @override
  dispose() {
    super.dispose();
    textSelectUrl;
    textSelectedPlatform;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom, //Push above keyboard
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Wrap content
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownMenu(
              hintText: 'choose your social',
              controller: textSelectedPlatform,
              dropdownMenuEntries: widget.listofSocialAvailable.map((e) {
                return DropdownMenuEntry(value: e, label: e);
              }).toList(),
            ),
            const SizedBox(height: 20),
            TextFormField(
              style: Theme.of(context).textTheme.bodyMedium,
              controller: textSelectUrl,
              decoration: const InputDecoration(
                hintText: "Enter your link",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 40),
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
                  if (textSelectUrl.text.contains(textSelectedPlatform.text)) {
                    widget.profileCubit.addOrupdateSoical(
                        SocialMediaLinksRequest(
                            platform: textSelectedPlatform.text,
                            url: textSelectUrl.text));
                  } else {
                    UIUtils.showMessage(
                        'Ther url that enter is not same type of platform');
                  }
                },
                child: const Text('Save'),
              ),
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
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
