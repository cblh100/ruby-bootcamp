require 'spec_helper'

describe Statement do

  describe '#new' do

    it 'raises an ArgumentError when no block is passed' do
      expect{ Statement.new }.to raise_error(ArgumentError, 'You must pass a block to initialize the Statement')
    end

    it 'requires a block to be passed' do
      expect(Statement.new {}).to be_instance_of(Statement)
    end

    it 'sets the attributes' do

      generated_date = Date.today

      statement = Statement.new do
        date generated_date
        due(date + (30 * 60 * 60 * 24))
        from Date.parse('2015-01-26')
        to Date.parse('2015-02-25')
        total 1.23

        call_charges do
          call '07716393769' do
            date Date.parse('2015-02-01')
            duration "00:23:03"
            cost 1.13
          end
        end
      end
      expect(statement.date).to eq(generated_date)
      expect(statement.due).to eq(generated_date + (30 * 60 * 60 * 24))
      expect(statement.from).to eq(Date.parse('2015-01-26'))
      expect(statement.to).to eq(Date.parse('2015-02-25'))
      expect(statement.total).to eq(1.23)
      expect(statement.call_charges.calls).not_to be_empty
    end
  end

  describe '#to_json' do

    let(:json_output) do json = <<JSON
{
  "statement": {
    "generated": "2015-01-11",
    "due": "2015-01-25",
    "period": {
      "from": "2015-01-26",
      "to": "2015-02-25"
    },
    "total": 1.23,
    "callCharges": {
      "calls": [
        {
          "called": "07716393769",
          "date": "2015-02-01",
          "duration": "00:23:03",
          "cost": 1.13
        },
        {
          "called": "07716393769",
          "date": "2015-02-01",
          "duration": "00:33:03",
          "cost": 2.13
        }
      ]
    }
  }
}
JSON
      json.chomp
    end

    it 'produces valid json that matches the DSL' do

      statement = Statement.new do
        date Date.parse('2015-01-11')
        due Date.parse('2015-01-25')
        from Date.parse('2015-01-26')
        to Date.parse('2015-02-25')
        total 1.23

        call_charges do
          call '07716393769' do
            date Date.parse('2015-02-01')
            duration "00:23:03"
            cost 1.13
          end
          call '07716393769' do
            date Date.parse('2015-02-01')
            duration "00:33:03"
            cost 2.13
          end
        end
      end
      expect(statement.to_json).to eq(json_output)
    end

  end

end
