START TRANSACTION;

-- --------------------------------------------------------
-- テーブルの構造 `users`
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS `users` (
  `id` VARCHAR(26) PRIMARY KEY,
  `name` VARCHAR(30) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin;

-- --------------------------------------------------------
-- テーブルの構造 `todo`
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS `todos` (
  `id` VARCHAR(26) PRIMARY KEY,
  `title` VARCHAR(200) NOT NULL,
  `status` INT NOT NULL DEFAULT 0,
  `user_id` VARCHAR(26) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin;

COMMIT;
