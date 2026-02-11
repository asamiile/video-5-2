// 地名設定の配列
import { fontFamily as FONT_FAMILY_LINE_SEED } from "@remotion/google-fonts/LineSeedJP";

export const locationConfigs = [
  {
    id: "LocationOverlay-TenjinBlickCross",
    locationName: "天神ブリッククロス",
    fontSize: 36,
  },
  {
    id: "LocationOverlay-OneFukuoka",
    locationName: "ONE FUKUOKA BLDG",
    fontSize: 36,
  },
  {
    id: "LocationOverlay-HurricSquare",
    locationName: "ヒューリックスクエア福岡天神",
    fontSize: 36,
  },
  {
    id: "LocationOverlay-Daimei",
    locationName: "大名ガーデンシティ",
    fontSize: 36,
  },
];

// 共通のデフォルトプロパティ
export const defaultLocationProps = {
  textColor: "rgba(255, 255, 255, 1)",
  backgroundColor: "rgb(195, 192, 187)",
  showBackground: true,
  positionX: 5,
  positionY: 90,
  fontFamily: FONT_FAMILY_LINE_SEED,
  fontWeight: "400" as const,
  animationDurationFrames: 8,
  slideInDistance: 300,
};
