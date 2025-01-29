#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}Setting up F3 Nation Data Management UI...${NC}"

# Check Python version
if ! command -v python3.12 &> /dev/null; then
    echo -e "${RED}Python 3.12 is required but not installed.${NC}"
    exit 1
fi

# Install poetry if not present
if ! command -v poetry &> /dev/null; then
    echo -e "${GREEN}Installing Poetry...${NC}"
    curl -sSL https://install.python-poetry.org | python3 -
fi

# Clean up any existing database
rm -f *.db

# Create minimal .env file
echo -e "${GREEN}Creating .env file...${NC}"
cat > .env << EOL
F3_EMAIL_PASSWORD=dummy_password
EOL

# Install dependencies
echo -e "${GREEN}Installing project dependencies...${NC}"
poetry install

# Initialize the database
echo -e "${GREEN}Initializing SQLite database...${NC}"
poetry run reflex db migrate

echo -e "${GREEN}Setup complete! To run the application:${NC}"
echo -e "1. Run: ${GREEN}poetry run reflex run${NC}"
echo -e "2. Visit: ${GREEN}http://localhost:3000/home${NC}"