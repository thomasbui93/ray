# frozen_string_literal: true

require 'test_helper'

class Vault::ValueTest < ActiveSupport::TestCase
  test 'vault should have an adjacent list tree relation with itself' do
    value = vault_values(:minimum_vault_parent)
    child = vault_values(:minimum_vault_child)
    assert Vault::Value.children(value.id).length, 1
    assert Vault::Value.children(value.id).first, child
  end
end
