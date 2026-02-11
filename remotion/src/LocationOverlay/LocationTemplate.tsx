import React from "react";
import { AbsoluteFill, useCurrentFrame } from "remotion";
import { LocationSchemaType } from "./location-schema";

export const LocationTemplate: React.FC<LocationSchemaType> = ({
  locationName,
  fontSize,
  textColor,
  backgroundColor,
  showBackground,
  positionX,
  positionY,
  fontFamily,
  fontWeight,
  animationDurationFrames,
  slideInDistance,
}) => {
  const frame = useCurrentFrame();
  
  // テキストスライドインアニメーション計算
  const textProgress = Math.min(frame / animationDurationFrames, 1);
  const translateXValue = slideInDistance * (1 - textProgress);

  // 線のスライドインアニメーション計算（テキスト完了後に開始）
  const lineDelayFrames = animationDurationFrames;
  const lineProgress = Math.max(0, Math.min((frame - lineDelayFrames) / animationDurationFrames, 1));
  const lineHeight = 100 * lineProgress;

  return (
    <AbsoluteFill
      style={{
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        backgroundColor: "transparent",
      }}
    >
      {/* 地名テキスト */}
      <div
        style={{
          position: "absolute",
          left: `${positionX}%`,
          top: `${positionY}%`,
          transform: `translate(calc(-${translateXValue}px), -50%)`,
          padding: showBackground ? "20px 40px" : "0",
          backgroundColor: showBackground ? backgroundColor : "transparent",
          backdropFilter: showBackground ? "blur(4px)" : "none",
        }}
      >
        <h1
          style={{
            margin: 0,
            fontSize: `${fontSize}px`,
            color: textColor,
            fontFamily: fontFamily,
            fontWeight: fontWeight as any,
            lineHeight: 1.2,
            whiteSpace: "nowrap",
          }}
        >
          {locationName}
        </h1>
      </div>

      {/* 線アニメーション */}
      <div
        style={{
          position: "absolute",
          left: `calc(${positionX}% + 1px)`,
          top: `calc(${positionY}% + ${fontSize / 2 + 20}px)`,
          width: "3px",
          height: `${lineHeight}px`,
          backgroundColor: backgroundColor,
          transformOrigin: "top center",
          transform: "translateX(-1px)",
        }}
      />
    </AbsoluteFill>
  );
};
