# frozen_string_literal: true

Sequel.migration do
  transaction

  up do
    extension :pg_triggers

    create_table(:personas) do
      Serial   :id, primary_key: true
      String   :dni, unique: true
      String   :name, size: 50, null: false
      Integer  :age, null: false
      String   :status, size: 20
      String   :description, size: 50

      DateTime :created_at, default: Sequel.function(:NOW)
      DateTime :updated_at, default: Sequel.function(:NOW)
    end

    pgt_updated_at(:personas,
                   :updated_at,
                   function_name: 'update_updated_at_column_at_persona_table',
                   trigger_name: :set_updated_at)
  end

  down do
    drop_trigger(:personas, :set_updated_at)
    drop_function(:update_updated_at_column_at_persona_table)
    drop_table(:personas)
  end
end
