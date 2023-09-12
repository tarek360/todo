sealed class ScreenState<T> {}

class ScreenStateLoading<T> implements ScreenState<T> {
  const ScreenStateLoading();
}

class ScreenStateData<T> implements ScreenState<T> {
  final T data;

  const ScreenStateData(this.data);
}

class ScreenStateNoData<T> implements ScreenState<T> {
  const ScreenStateNoData();
}

class ScreenStateError<T> implements ScreenState<T> {
  final String errorMessage;

  const ScreenStateError(this.errorMessage);
}
