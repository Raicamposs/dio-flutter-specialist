enum Breakpoints {
  sm(480.0),
  md(768.0),
  lg(992.0),
  xl(1280.0),
  xl2(1536.0);

  static bool isMobile(double width) {
    return width <= Breakpoints.md.size;
  }

  static bool isDesktop(double width) {
    return width > Breakpoints.md.size;
  }

  const Breakpoints(this.size);

  final double size;
}

enum Containers {
  xs(320.0),
  sm(640.0),
  md(768.0),
  lg(1024.0),
  xl(1280.0);

  const Containers(this.size);
  final double size;
}

abstract final class Spacing {
  static const s1 = 4.0;
  static const s2 = 8.0;
  static const s3 = 12.0;
  static const s4 = 16.0;
  static const s5 = 20.0;
  static const s6 = 24.0;
  static const s8 = 32.0;
  static const s10 = 40.0;
  static const s12 = 48.0;
  static const s16 = 64.0;
  static const s20 = 80.0;
  static const s24 = 96.0;
  static const s32 = 128.0;
  static const s40 = 160.0;
  static const s48 = 192.0;
  static const s56 = 224.0;
  static const s64 = 256.0;
}
