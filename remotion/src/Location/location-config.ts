// 地名設定の配列
import { fontFamily as FONT_FAMILY_LINE_SEED } from "@remotion/google-fonts/LineSeedJP";
import { msToFrame } from "../helpers/ms-to-frame";

export const locationConfigs = [
  {
    id: "Location-TenjinBrickCross",
    locationName: "天神ブリッククロス",
  },
  {
    id: "Location-OneFukuoka",
    locationName: "ONE FUKUOKA BLDG",
  },
  {
    id: "Location-InabaConstruction",
    locationName: "因幡町通り工事現場",
  },
  {
    id: "Location-HurricSquare",
    locationName: "ヒューリックスクエア福岡天神",
  },
  {
    id: "Location-DaimyoGardenCity",
    locationName: "大名ガーデンシティ",
  },
];

// 共通のデフォルトプロパティ
export const defaultLocationProps = {
  fontSize: 36,
  textColor: "rgb(195, 192, 187)",
  backgroundColor: "rgb(195, 192, 187)",
  showBackground: true,
  positionX: 5,
  positionY: 90,
  fontFamily: FONT_FAMILY_LINE_SEED,
  fontWeight: "400" as const,
  animationDurationFrames: 90, // 3科
  slideInDistance: 25,
  delayDurationFrames: 0, // アニメーション遅延
  fadeInDurationFrames: msToFrame(500), // フェードイン期間
  textPaddingX: 0,
  textPaddingY: 20,
  lineHeight: 4,
  lineMaxWidth: 504,
  lineSpacing: 20,
  circleSize: 12,
};
