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
  final bool issAprrovid;

  const SectionSocialLinks(
      {required this.profileCubit,
      required this.listOfSoicalFromApi,
      required this.providerId,
      super.key, required this.issAprrovid});

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
                listOfSocialFromApi: widget.listOfSoicalFromApi, issAprrovid: widget.issAprrovid,));
  }
}

class ShowSocialLinksForMyProfileWithOptions extends StatefulWidget {
  final List<ProviderProfileSocialLinks?>? listOfSocialFromApi;
  final ProfileCubit profileCubit;
  final bool issAprrovid;

  const ShowSocialLinksForMyProfileWithOptions(
      {required this.profileCubit,
      required this.listOfSocialFromApi,
      super.key, required this.issAprrovid});

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
                icon: Icon(Icons.add,color: widget.issAprrovid?ColorManager.primary:ColorManager.grey,))
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
  const SectionBodySheetAddLink({
    required this.listofSocialAvailable,
    required this.profileCubit,
    super.key,
  });

  @override
  State<SectionBodySheetAddLink> createState() => _SectionBodySheetAddLinkState();
}

class _SectionBodySheetAddLinkState extends State<SectionBodySheetAddLink> {
  TextEditingController platformController = TextEditingController();
  TextEditingController urlController = TextEditingController();

  @override
  void dispose() {
    platformController.dispose();
    urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add Social Link',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 20),

            // Platform Input Field
            TextFormField(
              controller: platformController,
              decoration: InputDecoration(
                hintText: "Enter platform (e.g., facebook, twitter)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(Icons.public),
              ),
            ),

            const SizedBox(height: 20),

            // URL Input Field
            TextFormField(
              controller: urlController,
              decoration: InputDecoration(
                hintText: "Enter your social link URL",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(Icons.link),
              ),
            ),

            const SizedBox(height: 30),

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
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Save'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  if (platformController.text.isNotEmpty &&
                      urlController.text.isNotEmpty) {
                    widget.profileCubit.addOrupdateSoical(SocialMediaLinksRequest(
                      platform: platformController.text.toLowerCase(),
                      url: urlController.text,
                    ));
                  } else {
                    UIUtils.showMessage(
                      'Please fill in both fields',
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class _SectionBodySheetAddLinkStateCustom extends State<SectionBodySheetAddLink> {
  // باقي الكود كما هو
  TextEditingController textSelectedPlatform = TextEditingController();
  TextEditingController textSelectUrl = TextEditingController();

  @override
  dispose() {
    textSelectUrl.dispose();
    textSelectedPlatform.dispose();
    super.dispose();
  }

  IconData _getIconForPlatform(String platform) {
    switch (platform.toLowerCase()) {
      case 'facebook':
        return Icons.facebook;
      case 'twitter':
        return Icons.facebook;
      case 'linkedin':
        return Icons.linked_camera;
      default:
        return Icons.link;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add Social Link',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
                value: widget.listofSocialAvailable.isNotEmpty
                    ? widget.listofSocialAvailable.first
                    : null,
                items: widget.listofSocialAvailable.map((platform) {
                  return DropdownMenuItem<String>(
                    value: platform,
                    child: Row(
                      children: [
                        Icon(_getIconForPlatform(platform), color: Colors.grey),
                        const SizedBox(width: 10),
                        Text(platform.toUpperCase()),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  textSelectedPlatform.text = value!;
                },
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              style: Theme.of(context).textTheme.bodyMedium,
              controller: textSelectUrl,
              decoration: InputDecoration(
                hintText: "Enter your social link",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(Icons.link),
              ),
            ),
            const SizedBox(height: 30),
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
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Save'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  if (textSelectUrl.text.contains(textSelectedPlatform.text)) {
                    widget.profileCubit.addOrupdateSoical(SocialMediaLinksRequest(
                      platform: textSelectedPlatform.text,
                      url: textSelectUrl.text,
                    ));
                  } else {
                    UIUtils.showMessage(
                      'The URL must match the selected platform.',
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

// class _SectionBodySheetAddLinkState extends State<SectionBodySheetAddLink> {
//   TextEditingController textSelectedPlatform = TextEditingController();
//   TextEditingController textSelectUrl = TextEditingController();
//   IconData _getIconForPlatform(String platform) {
//     switch (platform.toLowerCase()) {
//       case 'facebook':
//         return Icons.facebook;
//       case 'twitter':
//         return Icons.facebook;
//       case 'linkedin':
//         return Icons.linked_camera; // يمكنك تغييرها إلى أيقونة لينكدإن مناسبة
//       case 'instagram':
//         return Icons.camera_alt; // مثال لأيقونة إنستغرام
//       default:
//         return Icons.link;
//     }
//   }
//
//   @override
//   dispose() {
//     super.dispose();
//     textSelectUrl;
//     textSelectedPlatform;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         bottom: MediaQuery.of(context).viewInsets.bottom,
//       ),
//       child: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               'Add Social Link',
//               style: Theme.of(context).textTheme.titleMedium,
//             ),
//             const SizedBox(height: 20),
//
//             /// Custom Dropdown Style using ListTile
//             Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey.shade300),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: DropdownButtonFormField<String>(
//                 decoration: const InputDecoration(
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.symmetric(horizontal: 12),
//                 ),
//                 value: widget.listofSocialAvailable.isNotEmpty
//                     ? widget.listofSocialAvailable.first
//                     : null,
//                 items: widget.listofSocialAvailable.map((platform) {
//                   return DropdownMenuItem<String>(
//                     value: platform,
//                     child: Row(
//                       children: [
//                         Icon(_getIconForPlatform(platform), color: Colors.grey),
//                         const SizedBox(width: 10),
//                         Text(platform.toUpperCase()),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   textSelectedPlatform.text = value!;
//                 },
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             /// URL Input
//             TextFormField(
//               style: Theme.of(context).textTheme.bodyMedium,
//               controller: textSelectUrl,
//               decoration: InputDecoration(
//                 hintText: "Enter your social link",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 prefixIcon: const Icon(Icons.link),
//               ),
//             ),
//
//             const SizedBox(height: 30),
//
//             /// Save Button with BlocListener
//             BlocListener<ProfileCubit, ProfileStates>(
//               listener: (context, state) {
//                 if (state is AddorUpdateSoicalLinksLoading) {
//                   UIUtils.showLoadingDialog(context);
//                 } else if (state is AddorUpdateSoicalLinksError) {
//                   UIUtils.hideLoading(context);
//                   UIUtils.showMessage(state.message);
//                 } else if (state is AddorUpdateSoicalLinksSuccess) {
//                   UIUtils.hideLoading(context);
//                   Navigator.of(context).pop();
//                   widget.profileCubit.getUserRole();
//                 }
//               },
//               child: ElevatedButton.icon(
//                 icon: const Icon(Icons.save),
//                 label: const Text('Save'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: ColorManager.primary,
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                   textStyle: const TextStyle(fontSize: 16),
//                 ),
//                 onPressed: () {
//                   if (textSelectUrl.text.contains(textSelectedPlatform.text)) {
//                     widget.profileCubit.addOrupdateSoical(SocialMediaLinksRequest(
//                       platform: textSelectedPlatform.text,
//                       url: textSelectUrl.text,
//                     ));
//                   } else {
//                     UIUtils.showMessage(
//                       'The URL must match the selected platform.',
//                     );
//                   }
//                 },
//               ),
//             ),
//             const SizedBox(height: 10),
//           ],
//         ),
//       ),
//     );
//   }
//
// }

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


