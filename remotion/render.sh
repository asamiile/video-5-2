#!/bin/bash

# Remotion コンポジション レンダリングスクリプト
# 
# 使用方法:
#   chmod +x render
#   ./render              # すべてのコンポジションを書き出し（デフォルト）
#   ./render LoadingIcon  # LoadingIcon コンポジションを書き出し
#   ./render Location     # Location コンポジションを書き出し
#   ./render MiniMap      # MiniMap コンポジションを書き出し（WebGL required）
#   ./render all          # すべてのコンポジションを書き出し

set -e  # エラー時に停止

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_DIR="$SCRIPT_DIR/out"

# 設定
CONCURRENCY_LOADINGICON=4
CONCURRENCY_LOCATION=4
CONCURRENCY_MINIMAP=2
NETWORK_TIMEOUT=60000
CODEC="prores"
PRORES_PROFILE="4444"

# 出力ディレクトリ作成
mkdir -p "$OUTPUT_DIR"

# ロケーション一覧
LOCATIONS=(
  "TenjinBrickCross"
  "OneFukuoka"
  "InabaConstruction"
  "HurricSquare"
  "DaimyoGardenCity"
)

# LoadingIcon パターン一覧
LOADINGICON_PATTERNS=(
  "Default"
  "Large"
  "Custom"
  "DefaultWithText"
  "LargeWithText"
  "CustomWithText"
)

# 色出力用
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}🎬 Remotion Composition Rendering Script${NC}"
echo "Output directory: $OUTPUT_DIR"
echo ""

# LoadingIcon コンポジションを書き出し
render_loadingicon() {
  echo -e "${YELLOW}⏳ Rendering LoadingIcon compositions...${NC}"
  
  for pattern in "${LOADINGICON_PATTERNS[@]}"; do
    echo ""
    echo -e "${YELLOW}→ LoadingIcon-${pattern}${NC}"
    
    npx remotion render src/index.ts "LoadingIcon-${pattern}" \
      "$OUTPUT_DIR/LoadingIcon-${pattern}.mov" \
      --concurrency="$CONCURRENCY_LOADINGICON" \
      --network-timeout="$NETWORK_TIMEOUT" \
      --codec="$CODEC" \
      --prores-profile="$PRORES_PROFILE" \
      || {
        echo -e "${RED}✗ Failed to render LoadingIcon-${pattern}${NC}"
        return 1
      }
    
    echo -e "${GREEN}✓ LoadingIcon-${pattern} rendered${NC}"
  done
  
  echo ""
  echo -e "${GREEN}✅ All LoadingIcon compositions rendered successfully!${NC}"
}

# Location コンポジションを書き出し
render_location() {
  echo -e "${YELLOW}📍 Rendering Location compositions...${NC}"
  
  for location in "${LOCATIONS[@]}"; do
    echo ""
    echo -e "${YELLOW}→ Location-${location}${NC}"
    
    npx remotion render src/index.ts "Location-${location}" \
      "$OUTPUT_DIR/Location-${location}.mov" \
      --concurrency="$CONCURRENCY_LOCATION" \
      --network-timeout="$NETWORK_TIMEOUT" \
      --codec="$CODEC" \
      --prores-profile="$PRORES_PROFILE" \
      || {
        echo -e "${RED}✗ Failed to render Location-${location}${NC}"
        return 1
      }
    
    echo -e "${GREEN}✓ Location-${location} rendered${NC}"
  done
  
  echo ""
  echo -e "${GREEN}✅ All Location compositions rendered successfully!${NC}"
}

# MiniMap コンポジションを書き出し
render_minimap() {
  echo -e "${YELLOW}🗺️  Rendering MiniMap compositions (WebGL required - local only)...${NC}"
  echo -e "${YELLOW}⚠️  Note: WebGL may not work in all environments${NC}"
  echo ""
  
  for location in "${LOCATIONS[@]}"; do
    echo ""
    echo -e "${YELLOW}→ MiniMap-${location}${NC}"
    
    npx remotion render src/index.ts "MiniMap-${location}" \
      "$OUTPUT_DIR/MiniMap-${location}.mov" \
      --concurrency="$CONCURRENCY_MINIMAP" \
      --network-timeout=120000 \
      --gl=angle \
      --codec="$CODEC" \
      --prores-profile="$PRORES_PROFILE" \
      || {
        echo -e "${RED}✗ Failed to render MiniMap-${location}${NC}"
        echo -e "${YELLOW}💡 This is expected if WebGL is not available${NC}"
        return 1
      }
    
    echo -e "${GREEN}✓ MiniMap-${location} rendered${NC}"
  done
  
  echo ""
  echo -e "${GREEN}✅ All MiniMap compositions rendered successfully!${NC}"
}

# メイン処理
main() {
  case "${1:-all}" in
    LoadingIcon|loadingicon)
      render_loadingicon
      ;;
    Location|location)
      render_location
      ;;
    MiniMap|minimap)
      render_minimap
      ;;
    all)
      render_loadingicon
      render_location
      render_minimap
      ;;
    *)
      echo "Usage: $0 [LoadingIcon|Location|MiniMap|all]"
      echo ""
      echo "  LoadingIcon  Render all LoadingIcon compositions"
      echo "  Location     Render all Location compositions"
      echo "  MiniMap      Render all MiniMap compositions (WebGL required)"
      echo "  all          Render all compositions (default)"
      exit 1
      ;;
  esac
}

main "$@"
