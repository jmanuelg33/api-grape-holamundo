# frozen_string_literal: true

Sequel.migration do
  transaction

  up do
    extension :pg_triggers

    alter_table(:adresses) do
      add_foreign_key :persona_id, :personas
    end
  end

  down do
    drop_foreign_key :persona_id
  end
end
