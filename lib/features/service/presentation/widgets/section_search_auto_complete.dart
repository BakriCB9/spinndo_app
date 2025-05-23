import 'dart:async';
import 'package:app/core/constant.dart';
import 'package:app/core/resources/color_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:dio/dio.dart';

import 'package:app/core/di/service_locator.dart';

import 'package:app/features/service/presentation/cubit/service_cubit.dart';
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

  late final _Debounceable<Iterable<String>?, String> _debouncedSearch;

  @override
  void initState() {

    _debouncedSearch = _debounce<Iterable<String>?, String>(_search);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final localization = AppLocalizations.of(context)!;
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) async {
        final ans = await _debouncedSearch(textEditingValue.text);
        if (ans == null) {
          return [];
        } else {
          return ans;
        }
      },
      fieldViewBuilder: (context, text, focusNode, onFieldSubmitted) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor,
                blurRadius: 5,
                offset: Offset(0, 1),
              ),
            ],
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextField(
            style: theme.bodyMedium?.copyWith(
              fontSize: 28.sp,
            ),
            controller: text,
            focusNode: focusNode,
            decoration: InputDecoration(
              filled: true,
              hintText: localization.serviceOrProviderName,
              hintStyle: TextStyle(color: ColorManager.grey),
              prefixIcon: AnimatedBuilder(
                animation: focusNode!,
                builder: (context, child) {
                  return Transform.scale(
                    scale: focusNode!.hasFocus ? 1.3 : 1.0,
                    child: Icon(
                      Icons.search,
                      color: focusNode!.hasFocus
                          ? ColorManager.primary
                          : Colors.grey[700],
                    ),
                  );
                },
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: ColorManager.primary, width: 2),
              ),
            ),
          ),
        );
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
                  margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 0.w),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).shadowColor,
                        blurRadius: 6,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      option,
                      style: theme.bodyMedium!.copyWith(
                        fontSize: 27.sp,
                        color: ColorManager.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () => onSelected(option),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    hoverColor: Colors.amber.withOpacity(0.2),
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
