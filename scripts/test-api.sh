#!/bin/bash
# scripts/test-api.sh

echo "═══════════════════════════════════════════════════════"
echo "  🧪 Task Board API Test Suite"
echo "═══════════════════════════════════════════════════════"
echo ""

BASE_URL="http://localhost:3000/api"
HTTPS_URL="https://taskboard.local/api"
PASSED=0
FAILED=0

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

test_endpoint() {
    local name="$1"
    local method="$2"
    local url="$3"
    local data="$4"
    local expected="$5"
    local extra_flags="$6"

    echo -n "Testing: $name... "

    if [ "$method" = "GET" ]; then
        response=$(curl -s $extra_flags "$url")
    elif [ "$method" = "POST" ]; then
        response=$(curl -s $extra_flags -X POST -H "Content-Type: application/json" -d "$data" "$url")
    elif [ "$method" = "PATCH" ]; then
        response=$(curl -s $extra_flags -X PATCH -H "Content-Type: application/json" -d "$data" "$url")
    fi

    if echo "$response" | grep -q "$expected"; then
        echo -e "${GREEN}✓ PASSED${NC}"
        ((PASSED++))
    else
        echo -e "${RED}✗ FAILED${NC}"
        echo "  Response: $response"
        ((FAILED++))
    fi
}

echo "=== Testing Backend (Direct) ==="
echo ""

test_endpoint "Health Check" "GET" "$BASE_URL/health" "" "healthy"
test_endpoint "Get All Tasks" "GET" "$BASE_URL/tasks" "" "success"
test_endpoint "Get Statistics" "GET" "$BASE_URL/tasks/stats" "" "total"
test_endpoint "Create Task" "POST" "$BASE_URL/tasks" \
  '{"title":"Test Task from Script","priority":"MEDIUM"}' "Task created"
test_endpoint "Get Task by ID" "GET" "$BASE_URL/tasks/1" "" "success"
test_endpoint "Update Status" "PATCH" "$BASE_URL/tasks/1/status" \
  '{"status":"IN_PROGRESS"}' "success"

echo ""
echo "=== Testing via HTTPS (Nginx) ==="
echo ""

test_endpoint "HTTPS Health" "GET" "$HTTPS_URL/health" "" "healthy" "-k"
test_endpoint "HTTPS Get Tasks" "GET" "$HTTPS_URL/tasks" "" "success" "-k"

echo ""
echo "═══════════════════════════════════════════════════════"
echo "  Test Results: ${GREEN}$PASSED passed${NC}, ${RED}$FAILED failed${NC}"
echo "═══════════════════════════════════════════════════════"