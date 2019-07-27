import 'action.dart';

int counterReducer(int state, dynamic action) {
  if (action == ActionUnit.Increment) {
    return state + 1;
  }
  return state;
}