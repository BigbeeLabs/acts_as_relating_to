module ActsAsRelatingTo
  module ClassMethods
    module PoroHasMany
      def poro_has_many

        define_method_owned_relationships
        define_method_referencing_relationships

      end
    end
  end
end