CREATE TABLE `vehicles` (
    `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `model` INTEGER NOT NULL,
    `x` REAL NOT NULL,
    `y` REAL NOT NULL,
    `z` REAL NOT NULL,
    `rotation_x` REAL NOT NULL,
    `rotation_y` REAL NOT NULL,
    `rotation_z` REAL NOT NULL
)