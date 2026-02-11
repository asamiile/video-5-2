import { loadFont, fontFamily as ibmPlexFontFamily } from "@remotion/google-fonts/IBMPlexSans";
import { LineSeedJP_400, LineSeedJP_700 } from "@remotion/google-fonts/LineSeedJP";

// ============================================
// IBM Plex Sans（Audiogramで使用）
// ============================================
const ibmPlexLoading = loadFont("normal", {
  weights: ["500", "600"],
});

export const FONT_FAMILY_IBM_PLEX = ibmPlexFontFamily;

export const waitForIBMPlexFonts = async () => {
  await ibmPlexLoading.waitUntilDone();
};

// ============================================
// LINE Seed JP
// ============================================
export const loadLineSeedJPFonts = () => {
  return [LineSeedJP_400, LineSeedJP_700];
};

export const FONT_FAMILY_LINE_SEED = "LINE Seed JP";

// ============================================
// レガシー互換性のためのエクスポート
// ============================================
export const FONT_FAMILY = FONT_FAMILY_IBM_PLEX;
export const waitForFonts = waitForIBMPlexFonts;
