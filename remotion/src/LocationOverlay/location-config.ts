// 地名設定の配列
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
  backgroundColor: "rgba(42, 39, 20, 0.40)",
  showBackground: true,
  positionX: 5,
  positionY: 90,
  fontFamily: "LINE Seed JP",
  fontWeight: "400" as const,
  animationDurationFrames: 8,
  slideInDistance: 300,
};
