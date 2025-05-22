import 'dart:async';
import 'package:app/core/constant.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:dio/dio.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/features/service/presentation/cubit/service_setting_cubit.dart';

typedef _Debounceable<S, T> = Future<S?> Function(T parameter);

class SectionSearchAutoComplete extends StatefulWidget {
final   ServiceSettingCubit serviceSettingCubit;
  const SectionSearchAutoComplete({required this.serviceSettingCubit, super.key});

  @override
  State<SectionSearchAutoComplete> createState() =>
      _SectionSearchAutoCompleteState();
}

class _SectionSearchAutoCompleteState extends State<SectionSearchAutoComplete> {
  // late ServiceCubit _serviceCubit;

  late final _Debounceable<Iterable<String>?, String> _debouncedSearch;
  @override
  void initState() {
    // _serviceCubit = serviceLocator.get<ServiceCubit>();

    _debouncedSearch = _debounce<Iterable<String>?, String>(_search);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    
    final localization = AppLocalizations.of(context)!;
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) async {
        print('the value of list search is ${textEditingValue.text}');
        final ans = await _debouncedSearch(textEditingValue.text);
        if (ans == null) {
          return [];
        } else {
          return ans;
        }
      },
      fieldViewBuilder: (context, text, focusNode, onFieldSubmitted) {
        return TextField(
          style: theme.bodyMedium,
          controller: text, // ✅ Must use the passed controller
          focusNode: focusNode, // ✅ Must use the passed focus node

          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: localization.serviceOrProviderName,
          ),
        );

        // return CustomTextFormField(
        //   icon: Icons.search,
        //   controller: text,
        //   hintText: localization.serviceOrProviderName,

        //   // padding: 20.w,
        // );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 2,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: options.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final option = options.elementAt(index);
                return Container(
                  color: ColorManager.primary,
                  child: ListTile(
                    title: Text(
                      option,
                      style: theme.bodyMedium!.copyWith(fontSize: 27.sp),
                    ),
                    onTap: () => onSelected(option),
                    tileColor: Colors.grey[100],
                    hoverColor: Colors.greenAccent,
                  ),
                );
              },
            ),
          ),
        );
      },
      onSelected: (selection) {
    widget.serviceSettingCubit.searchController.text=selection;
      },
    );
  }
}

_Debounceable<S, T> _debounce<S, T>(_Debounceable<S?, T> function) {
  _DebounceTimer? debounceTimer;

  return (T parameter) async {
    if (debounceTimer != null && !debounceTimer!.isCompleted) {
      debounceTimer!.cancel();
    }
    debounceTimer = _DebounceTimer();
    try {
      await debounceTimer!.future;
    } on _CancelException {
      return null;
    }
    return function(parameter);
  };
}

// A wrapper around Timer used for debouncing.
class _DebounceTimer {
  _DebounceTimer() {
    _timer = Timer(const Duration(milliseconds: 700), _onComplete);
  }

  late final Timer _timer;
  final Completer<void> _completer = Completer<void>();

  void _onComplete() {
    _completer.complete();
  }

  Future<void> get future => _completer.future;

  bool get isCompleted => _completer.isCompleted;

  void cancel() {
    _timer.cancel();
    _completer.completeError(const _CancelException());
  }
}

class _CancelException implements Exception {
  const _CancelException();
}

Future<Iterable<String>?> _search(String query) async {
  print(
      'we are in shared prefrence now **********************************************');
  final Dio _dio = serviceLocator.get<Dio>();
  final SharedPreferences _sharedPreferences =
      serviceLocator.get<SharedPreferences>();
  final lang = _sharedPreferences.getString('language');

  try {
    final ans = await _dio.get(ApiConstant.getDataAutoComplete,
        options: Options(headers: {
          "Accept-Language": '$lang',
          "Content-Type": "application/json",
        }),
        data: {"key": query});
    List<dynamic> list = ans.data;
    List<String> listOfitem = [];
    for (int i = 0; i < list.length; i++) {
      listOfitem.add(list[i]);
    }
    print(
        'the list is now ################################################# ${list}');
    return listOfitem.map((e) {
      return e;
    });
  } catch (e) {
    print('there are are there ******************** $e');
    return null;
  }
}
