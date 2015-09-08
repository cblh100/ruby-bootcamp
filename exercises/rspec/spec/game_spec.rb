require 'spec_helper'

describe Game do

  subject(:game) { described_class.new }

  describe '#play' do

    before do
      allow(subject).to receive(:get_users_weapon).and_return(:paper)
    end

    it 'take the users weapon and the user wins' do
      allow(subject).to receive(:get_computers_weapon).and_return(:rock)
      expect{subject.play}.to output("You win, woohoo\n").to_stdout
    end

    it 'take the users weapon and the computer wins' do
      allow(subject).to receive(:get_computers_weapon).and_return(:scissors)
      expect{subject.play}.to output("Loser, the computer won\n").to_stdout
    end

    it 'take the users weapon and its a draw' do
      allow(subject).to receive(:get_computers_weapon).and_return(:paper)
      expect{subject.play}.to output("It's a draw!\n").to_stdout
    end

  end

  describe '#get_users_weapon' do

    let(:prompt_message) { "Pick your weapon...\n" }

    before do
      allow(subject).to receive(:gets).and_return('paper')
    end

    it 'prompts the user to pick a weapon' do
      expect{subject.get_users_weapon}.to output(prompt_message).to_stdout
    end

    it 'returns the users weapon' do
      allow(subject).to receive(:puts)
      expect(subject.get_users_weapon).to eq(:paper)
    end

  end

  describe '#get_computers_weapon' do

    it 'returns as valid weapon' do
      expect(subject.get_computers_weapon).to satisfy { |value| [:rock, :paper, :scissors].include? value }
    end

  end

  describe '#call' do

    context 'when the choices are the same' do

      it 'draw' do
        expect(subject.winner( :paper, :paper )).to eq(:draw)
      end

    end

    describe 'when the choices are different' do

      context 'player 1 beats player 2' do

        it 'scissors beats paper' do
          expect(subject.winner( :scissors, :paper )).to eq(:player1)
        end

        it 'paper beats rock' do
          expect(subject.winner( :paper, :rock )).to eq(:player1)
        end

        it 'rock beats scissors' do
          expect(subject.winner( :rock, :scissors )).to eq(:player1)
        end

      end

      context 'player 2 beats player 1' do

        it 'scissors beats paper' do
          expect(subject.winner( :paper, :scissors )).to eq(:player2)
        end

        it 'paper beats rock' do
          expect(subject.winner( :rock, :paper )).to eq(:player2)
        end

        it 'rock beats scissors' do
          expect(subject.winner( :scissors, :rock )).to eq(:player2)
        end

      end


    end

  end


end