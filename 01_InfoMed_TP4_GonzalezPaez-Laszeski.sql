-- Solo crear el índice si no existe
CREATE INDEX IF NOT EXISTS idx_pacientes_ciudad ON Pacientes(ciudad);