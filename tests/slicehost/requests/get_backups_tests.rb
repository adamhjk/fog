Shindo.tests('Slicehost#get_backups', 'slicehost') do
  tests('success') do

    before do
      @data = Slicehost[:slices].get_backups.body
    end

    # TODO: ensure this still works with a non-empty list
    test('has proper output format') do
      validate_format(@data, { 'backups' => [Slicehost::Formats::BACKUP] })
    end

  end
end
