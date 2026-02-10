/// App image paths and constants
class AppImages {
  AppImages._();

  // ─── Cloudinary URL helpers ───────────────────────────────────────────
  // Base transform: auto-format (WebP/AVIF) + auto-quality for best speed & quality
  static const String _base =
      'https://res.cloudinary.com/dkuyfevtc/image/upload';

  /// Apply Cloudinary transformations to a raw URL.
  /// [width] – resize width (Cloudinary keeps aspect ratio).
  /// If [width] is null, only format+quality optimization is applied.
  static String _url(String path, {int? width}) {
    final transforms = width != null
        ? 'f_auto,q_auto,w_$width'
        : 'f_auto,q_auto';
    return '$_base/$transforms/$path';
  }

  // ─── Background images ────────────────────────────────────────────────
  // Hero bg is displayed full-width, so use 1200px
  static final String heroBg = _url('v1770737248/bg_rlfhes.png', width: 1200);

  // ─── Profile ──────────────────────────────────────────────────────────
  // Profile card is max ~500px wide
  static final String profile = _url(
    'v1770732803/profile.png_dshwyx.png',
    width: 500,
  );

  // ─── Project screenshot helpers ───────────────────────────────────────
  // Phone mockup screenshots are ~220px wide → serve at 440px (2x retina)
  static const int _screenshotWidth = 440;

  // brain gurd project images
  static final List<String> brainGurdImages = [
    _url('v1770740106/braingurd1_jovn4z.png', width: _screenshotWidth),
    _url('v1770740109/braingurd2_xgogr8.png', width: _screenshotWidth),
    _url('v1770740104/braingurd3_copg6v.png', width: _screenshotWidth),
  ];

  // Deep Quran project images
  static final List<String> deepQuranImages = [
    _url('v1770740199/deepquran_y2pjgy.png', width: _screenshotWidth),
    _url('v1770740201/deepquran1_jqw4cg.png', width: _screenshotWidth),
    _url('v1770740202/deepquran2_eftyn0.png', width: _screenshotWidth),
    _url('v1770740203/deepquran3_silmhi.png', width: _screenshotWidth),
    _url('v1770740205/deepquran4_rgaj9n.png', width: _screenshotWidth),
    _url('v1770740206/deepquran5_jur030.png', width: _screenshotWidth),
    _url('v1770740207/deepquran7_kdlfzq.png', width: _screenshotWidth),
    _url('v1770740209/deepquran8_gxt13e.png', width: _screenshotWidth),
    _url('v1770740211/deepquran9_ljiae3.png', width: _screenshotWidth),
  ];

  // giomax project images
  static final List<String> giomaxImages = [
    _url('v1770740786/giomax1_leqp7p.png', width: _screenshotWidth),
    _url('v1770740789/giomax2_et8fzg.png', width: _screenshotWidth),
    _url('v1770740790/giomax3_wbqswr.png', width: _screenshotWidth),
    _url('v1770740791/giomax4_evte6k.png', width: _screenshotWidth),
    _url('v1770740791/giomax5_joe1jv.png', width: _screenshotWidth),
    _url('v1770740793/giomax6_rnedzq.png', width: _screenshotWidth),
    _url('v1770740794/giomax7_wgew9f.png', width: _screenshotWidth),
    _url('v1770740795/giomax8_ghvqlx.png', width: _screenshotWidth),
    _url('v1770740796/giomax9_jyqegh.png', width: _screenshotWidth),
    _url('v1770740786/giomax10_lhpjfo.jpg', width: _screenshotWidth),
    _url('v1770740787/giomax11_ed0am7.jpg', width: _screenshotWidth),
  ];

  // Medix project images
  static final List<String> medixImages = [
    _url('v1770740643/medix_squ5mc.png', width: _screenshotWidth),
    _url('v1770740643/medix1_c4gb4s.png', width: _screenshotWidth),
    _url('v1770740644/medix2_fz8klm.png', width: _screenshotWidth),
    _url('v1770740644/medix3_obhyuz.png', width: _screenshotWidth),
    _url('v1770740644/medix4_dxd7ei.png', width: _screenshotWidth),
    _url('v1770740646/medix5_olavds.png', width: _screenshotWidth),
  ];

  // reparo project images
  static final List<String> reparoImages = [
    _url('v1770740689/reparo_zhnx7h.jpg', width: _screenshotWidth),
    _url('v1770740690/reparo1_e2pnl6.png', width: _screenshotWidth),
    _url('v1770740691/reparo2_qmvp3x.png', width: _screenshotWidth),
    _url('v1770740691/reparo3_novtpr.png', width: _screenshotWidth),
    _url('v1770740692/reparo4_dtnrw6.png', width: _screenshotWidth),
    _url('v1770740693/reparo5_jj7v3w.jpg', width: _screenshotWidth),
    _url('v1770740694/reparo6_mlhg4c.png', width: _screenshotWidth),
    _url('v1770740695/reparo7_xbjply.png', width: _screenshotWidth),
    _url('v1770740695/reparo8_ter4nj.png', width: _screenshotWidth),
    _url('v1770740696/reparo9_szyo4u.png', width: _screenshotWidth),
  ];

  // roman project images
  static final List<String> romanImages = [
    _url('v1770740715/roman_dmp6m9.png', width: _screenshotWidth),
    _url('v1770740716/roman1_i3njuq.png', width: _screenshotWidth),
    _url('v1770740717/roman2_dxwstl.png', width: _screenshotWidth),
    _url('v1770740717/roman3_coimbn.png', width: _screenshotWidth),
    _url('v1770740718/roman4_udmo0d.png', width: _screenshotWidth),
  ];

  // TradeBridge project images
  static final List<String> tradeBridgeImages = [
    _url('v1770740737/hamdan1_iaendk.png', width: _screenshotWidth),
    _url('v1770740738/hamdan2_ljyy0o.png', width: _screenshotWidth),
    _url('v1770740739/hamdan3_llxtql.png', width: _screenshotWidth),
    _url('v1770740740/hamdan4_g23epr.png', width: _screenshotWidth),
    _url('v1770740741/hamdan5_t4f5ck.png', width: _screenshotWidth),
    _url('v1770740742/hamdan6_smsyvx.png', width: _screenshotWidth),
    _url('v1770740743/hamdan7_fimsw4.png', width: _screenshotWidth),
    _url('v1770740744/hamdan8_s53dvg.png', width: _screenshotWidth),
  ];
}
