abstract class AppConstant{
  static const oneOffTaskId = 'subscription-one-off-task';
  static const periodicTaskId = 'subscription-periodic-task';
}

abstract class Breakpoints {
  static const double mobile = 600;   // width < 600 → phone
}

const noUpdate = Object();