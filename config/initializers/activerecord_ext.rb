module ActiveRecord
  module ConnectionAdapters
    module SchemaStatements
      def create_table_with_dynamic_row_format(table_name, options = {}, &block)
        new_options = options.dup
        new_options[:options] ||= ""
        new_options[:options] << " DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC"
        create_table_without_dynamic_row_format(table_name, new_options, &block)
      end

      alias_method_chain :create_table, :dynamic_row_format
    end
  end
end