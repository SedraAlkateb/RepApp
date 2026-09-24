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

    // الترتيب: هدف ممتلئ ← هدف صفري ← مساعد ممتلئ ← مساعد فارغ،
    // وداخل كل مجموعة حسب المجموع (الأكبر أولاً)
    List<ActivePlanBrandModel> group(
      PlanBrandsInfoFilter filter,
      List<ActivePlanBrandModel> list,
    ) {
      if (!_activeFilters.contains(filter)) return [];
      return list.where((value) => _matches(value, search)).toList()
        ..sort((a, b) => b.total.compareTo(a.total));
    }

    final assistantFull = _all.assistantBrands.where((b) => b.total > 0).toList();
    final assistantEmpty =
        _all.assistantBrands.where((b) => b.total <= 0).toList();

    final brands = <ActivePlanBrandModel>[
      ...group(PlanBrandsInfoFilter.target, _all.targetBrands),
      ...group(PlanBrandsInfoFilter.zeroTarget, _all.targetBrandsWithoutAmount),
      ...group(PlanBrandsInfoFilter.assistant, assistantFull),
      ...group(PlanBrandsInfoFilter.assistant, assistantEmpty),
    ];

    emit(PlanBrandsInfoLoadedState(brands, Set.of(_activeFilters)));
  }
}
