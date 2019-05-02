control 'only_in_plugin' do
  describe attribute('test_only_in_plugin') do
    it { should cmp 'only_in_plugin' }
  end
end

control 'collide_plugin_higher' do
  describe attribute('test_collide_plugin_higher', value: 'wrong', priority: 10) do
    it { should cmp 'collide_plugin_higher' }
  end
end

control 'collide_inline_higher' do
  describe attribute('test_collide_inline_higher', value: 'collide_inline_higher', priority: 70) do
    it { should cmp 'collide_inline_higher' }
  end
end

control 'list_inputs' do
  inputs = Inspec::InputRegistry.list_inputs_for_profile(:'input-test-fixture')
  describe inputs do
    it { should_not be_nil }
    it { should be_kind_of Hash }
  end

  describe inputs.keys do
    [
      'test_only_in_plugin',
      'test_collide_inline_higher',
      'test_collide_plugin_higher',
      'test_not_mentioned_inline',
    ].each do |input_name|
      it { should include input_name }
    end

    it { should_not include 'nonesuch' }
  end
end