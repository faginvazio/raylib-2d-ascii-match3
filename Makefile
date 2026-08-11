# --- COMPILER & TOOLS ---
CC		:= gcc
CFLAGS		:= -Wall -Wextra -std=c99 -O2

# --- DIRECTORIES ---
SRC_DIR		:= src
BUILD_DIR	:= build

# Global raylib installation paths on C: drive
RAYLIB_INC 	:= C:/raylib/w64devkit/include
RAYLIB_LIB	:= C:/raylib/w64devkit/lib

# --- TARGET NAME ---
TARGET		:= $(BUILD_DIR)/game.exe

# --- FILES ---
SRCS		:= $(wildcard $(SRC_DIR)/*.c)
OBJS		:= $(SRCS:$(SRC_DIR)/%.c=$(BUILD_DIR)/%.o)

# --- INCLUDES & LIBRARIES ---
#  Use forward slashes as they are univerally understood by GCC on Windows
INCLUDES 	:= -I$(RAYLIB_INC)
LDFLAGS		:= -L$(RAYLIB_LIB)

# Core libraries required by raylib on Windows
LIBS		:= -lraylib -lopengl32 -lgdi32 -lwinmm

# --- BUILD RULES ---
.PHONY: all clean run

all: $(TARGET)

# Link the final executable
$(TARGET): $(OBJS)
	@mkdir -p $(BUILD_DIR)
	$(CC) $(OBJS) -o $(TARGET) $(LDFLAGS) $(LIBS)


# Compile C source files into object files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@


# Run the compiled executable
run: all
	cd $(BUILD_DIR) && ./game.exe


# Clean build artifacts
clean: 
	@rm -rf $(BUILD_DIR)

