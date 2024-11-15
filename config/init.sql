DO
$$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_database WHERE datname='writehub_production') THEN
      CREATE DATABASE writehub_production;
    END IF;
END
$$ LANGUAGE plpgsql;