# frozen_string_literal: true

Sequel.migration do
  transaction

  up do
    extension :pg_triggers

    create_table(:adresses) do
      Serial   :id, primary_key: true
      String   :province, size: 100, null: false
      String   :town, size: 100, null: false
      String   :address, size: 100, null: false

      DateTime :created_at, default: Sequel.function(:NOW)
      DateTime :updated_at, default: Sequel.function(:NOW)
    end

    pgt_updated_at(:adresses,
                   :updated_at,
                   function_name: 'update_updated_at_column_at_adresses_table',
                   trigger_name: :set_updated_at)
  end

  down do
    drop_trigger(:adresses, :set_updated_at)
    drop_function(:update_updated_at_column_at_adresses_table)
    drop_table(:adresses)
  end
end
