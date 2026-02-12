#!/bin/bash

# Remotion 地図動画レンダリングスクリプト
# 
# 使用方法:
#   chmod +x render-maps.sh
#   ./render-maps.sh              # 全 Location を書き出し
#   ./render-maps.sh location     # Location のみ書き出し
#   ./render-maps.sh minimap      # MiniMap を書き出し（ローカル環境のみ）

set -e  # エラー時に停止

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_DIR="$SCRIPT_DIR/out"

# 設定
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

# 色出力用
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}🎬 Remotion Map Rendering Script${NC}"
echo "Output directory: $OUTPUT_DIR"
echo ""

# Location 映像を書き出し
render_locations() {
  echo -e "${YELLOW}📍 Rendering Location videos...${NC}"
  
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
  echo -e "${GREEN}✅ All Location videos rendered successfully!${NC}"
}

# MiniMap 映像を書き出し
render_minimap() {
  echo -e "${YELLOW}🗺️  Rendering MiniMap videos (WebGL required - local only)...${NC}"
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
  echo -e "${GREEN}✅ All MiniMap videos rendered successfully!${NC}"
}

# メイン処理
main() {
  case "${1:-location}" in
    location)
      render_locations
      ;;
    minimap)
      render_minimap
      ;;
    all)
      render_locations
      render_minimap
      ;;
    *)
      echo "Usage: $0 [location|minimap|all]"
      echo ""
      echo "  location  Render all Location videos (recommended)"
      echo "  minimap   Render all MiniMap videos (WebGL required)"
      echo "  all       Render both Location and MiniMap"
      exit 1
      ;;
  esac
}

main "$@"
