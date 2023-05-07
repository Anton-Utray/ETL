-- empezamos asignando tipo de datos correcto y indice para la que va a ser la FK de cada tabla alcaldia_id -- 

ALTER TABLE agua_cdmx.alcaldias
MODIFY COLUMN alcaldia VARCHAR(200),
ADD PRIMARY KEY (alcaldia_id);

ALTER TABLE agua_cdmx.censo_agua
MODIFY COLUMN alcaldia VARCHAR(200),
MODIFY COLUMN disponibilidad VARCHAR(200),
MODIFY COLUMN fuente VARCHAR(200),
ADD INDEX fk_alcaldias_alcaldiaid_idx (alcaldia_id ASC) VISIBLE,
ADD COLUMN id SERIAL PRIMARY KEY;

ALTER TABLE agua_cdmx.ids 
RENAME COLUMN IDS TO IDS_num,
RENAME COLUMN E_IDS_V TO IDS,
RENAME COLUMN clave TO alcaldia_id;

ALTER TABLE agua_cdmx.ids
MODIFY COLUMN alcaldia VARCHAR(200),
MODIFY COLUMN IDS_num FLOAT,
MODIFY COLUMN IDS VARCHAR(200),
ADD INDEX fk_alcaldias_alcaldiaid_idx (alcaldia_id ASC) VISIBLE,
ADD COLUMN id SERIAL PRIMARY KEY;

ALTER TABLE agua_cdmx.proyectos_captacion
MODIFY COLUMN alcaldia VARCHAR(200),
MODIFY COLUMN latitud VARCHAR(200),
MODIFY COLUMN longitud VARCHAR(200),
ADD INDEX fk_alcaldias_alcaldiaid_idx (alcaldia_id ASC) VISIBLE,
ADD COLUMN id SERIAL PRIMARY KEY;

-- ahora asignamos FK

ALTER TABLE agua_cdmx.censo_agua
ADD CONSTRAINT fk_alcaldias_alcaldiaid
  FOREIGN KEY (alcaldia_id)
  REFERENCES agua_cdmx.alcaldias (alcaldia_id)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
ALTER TABLE agua_cdmx.ids
MODIFY COLUMN alcaldia_id BIGINT;
ALTER TABLE agua_cdmx.ids
ADD CONSTRAINT fk_alcaldias_alcaldiaid1
  FOREIGN KEY (alcaldia_id)
  REFERENCES agua_cdmx.alcaldias (alcaldia_id)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
ALTER TABLE agua_cdmx.proyectos_captacion
ADD CONSTRAINT fk_alcaldias_alcaldiaid2
  FOREIGN KEY (alcaldia_id)
  REFERENCES agua_cdmx.alcaldias (alcaldia_id)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION; 