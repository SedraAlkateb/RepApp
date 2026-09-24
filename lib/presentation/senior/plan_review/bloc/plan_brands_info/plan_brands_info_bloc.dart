import 'package:bloc/bloc.dart';
import 'package:domina_app/domain/failure.dart';
import 'package:domina_app/domain/models/models.dart';
import 'package:domina_app/domain/usecase/get_plan_brands_info_usecase.dart';
import 'package:domina_app/presentation/uniti/search.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'plan_brands_info_event.dart';
part 'plan_brands_info_state.dart';

class PlanBrandsInfoBloc
    extends Bloc<PlanBrandsInfoEvent, PlanBrandsInfoState> {
  final GetPlanBrandsInfoUsecase getPlanBrandsInfoUsecase;

  AllPlanBrandsInfo _all = AllPlanBrandsInfo([], [], []);
  String _search = '';
  Set<PlanBrandsInfoFilter> _activeFilters = PlanBrandsInfoFilter.values.toSet();

  PlanBrandsInfoBloc(this.getPlanBrandsInfoUsecase)
      : super(PlanBrandsInfoInitial()) {
    on<GetPlanBrandsInfoEvent>(_onGet);
    on<SearchPlanBrandsInfoEvent>((event, emit) {
      _search = event.search;
      _emitLoaded(emit);
    });
    on<ApplyInfoFiltersEvent>((event, emit) {
      _activeFilters = Set.of(event.filters);
      _emitLoaded(emit);
    });
  }

  Future<void> _onGet(
    GetPlanBrandsInfoEvent event,
    Emitter<PlanBrandsInfoState> emit,
  ) async {
    emit(PlanBrandsInfoLoadingState());
    final result = await getPlanBrandsInfoUsecase.execute(event.repPlanId);
    result.fold(
      (failure) => emit(PlanBrandsInfoErrorState(failure: failure)),
      (data) {
        _all = data;
        _search = '';
        _activeFilters = PlanBrandsInfoFilter.values.toSet();
        _emitLoaded(emit);
      },
    );
  }

  bool _matches(ActivePlanBrandModel value, String search) {
    return normalizeText(value.title).contains(search) ||
        value.spPlan.any(
          (specialty) => normalizeText(specialty.name).contains(search),
        ) ||
        normalizeText(value.pharmaceuticalFormTitle).contains(search) ||
        normalizeText(value.type.name).contains(search);
  }

  void _emitLoaded(Emitter<PlanBrandsInfoState> emit) {
    final search = normalizeText(_search);

    // الترتيب حسب المجموع (الأكبر أولاً)، وعند التساوي يبقى الترتيب:
    // هدف ممتلئ ← هدف صفري ← مساعد
    final merged = <ActivePlanBrandModel>[
      if (_activeFilters.contains(PlanBrandsInfoFilter.target))
        ..._all.targetBrands,
      if (_activeFilters.contains(PlanBrandsInfoFilter.zeroTarget))
        ..._all.targetBrandsWithoutAmount,
      if (_activeFilters.contains(PlanBrandsInfoFilter.assistant))
        ..._all.assistantBrands,
    ].where((value) => _matches(value, search)).toList();

    final order = {for (var i = 0; i < merged.length; i++) merged[i]: i};
    final brands = [...merged]..sort((a, b) {
        final byTotal = b.total.compareTo(a.total);
        return byTotal != 0 ? byTotal : order[a]!.compareTo(order[b]!);
      });

    emit(PlanBrandsInfoLoadedState(brands, Set.of(_activeFilters)));
  }
}
