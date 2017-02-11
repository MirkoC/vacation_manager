require 'rails_helper'

RSpec.describe Vacation, type: :model do
  describe :create do
    let!(:manager) {create(:manager) }
    let!(:worker) { create(:worker) }

    it 'creates a vacation for a manager' do
      expect do
        Vacation.create(start_date: 6.days.from_now, end_date: 20.days.from_now, vacationable: manager)
      end.to change { Vacation.count }.by(1)
    end

    it 'creates a vacation for a worker' do
      expect do
        Vacation.create(start_date: 6.days.from_now, end_date: 20.days.from_now, vacationable: worker)
      end.to change { Vacation.count }.by(1)
    end

    describe :rule_30_days do
      it 'cannot create vacation since there is not enough vacation days left' do
        worker = create(:worker)
        create(:vacation, start_date: 2.days.ago, end_date: 1.day.ago, vacationable: worker)
        expect do
          create(:vacation, start_date: 100.days.from_now, end_date: 130.days.from_now, vacationable: worker)
        end.to raise_exception(ActiveRecord::RecordInvalid, 'Validation failed: Not enough vacation days')
      end

      it 'cannot create vacation since vacation lasts more than 30 days' do
        worker = create(:worker)
        expect do
          create(:vacation, start_date: 100.days.from_now, end_date: 150.days.from_now, vacationable: worker)
        end.to raise_exception(ActiveRecord::RecordInvalid, 'Validation failed: Not enough vacation days, Vacation too long')
      end
    end

    describe :rule_60_days_gap do
      it 'cannot create vacation since there is no 60 days gap between two vacations' do
        worker = create(:worker)
        create(:vacation, start_date: 2.days.ago, end_date: 1.day.ago, vacationable: worker)
        expect do
          create(:vacation, start_date: 10.days.from_now, end_date: 13.days.from_now, vacationable: worker)
        end.to raise_exception(ActiveRecord::RecordInvalid, 'Validation failed: Must be 60 days gap between two vacations')
      end
    end

    describe :rule_workers_on_vacation do
      it 'can create vacation since there are half or less workers on vacation' do
        18.times do
          create(:worker)
        end
        Worker.first(4).each do |worker|
          create(:vacation, start_date: 1.day.from_now, end_date: 10.days.from_now, vacationable: worker)
        end
        expect do
          create(:vacation, start_date: 1.day.from_now, end_date: 10.days.from_now, vacationable: Worker.last)
        end.to change { Vacation.count }.by(1)
      end

      it 'cannot create vacation since there are half or more workers on vacation' do
        8.times do
          create(:worker)
        end
        Worker.first(4).each do |worker|
          create(:vacation, start_date: 1.day.from_now, end_date: 10.days.from_now, vacationable: worker)
        end
        expect do
          create(:vacation, start_date: 1.day.from_now, end_date: 10.days.from_now, vacationable: Worker.last)
        end.to raise_exception(ActiveRecord::RecordInvalid, 'Validation failed: Too many workers on vacation')
      end
    end

    describe :rule_manager_on_vacation do
      it 'can create vacation since there are 1/10th or less managers on vacation' do
        25.times do
          create(:manager)
        end
        create(:vacation, start_date: 1.day.from_now, end_date: 10.days.from_now, vacationable: Manager.first)
        expect do
          create(:vacation, start_date: 1.day.from_now, end_date: 10.days.from_now, vacationable: Manager.last)
        end.to change { Vacation.count }.by(1)
      end

      it 'cannot create vacation since there are half or more workers on vacation' do
        10.times do
          create(:manager)
        end
        create(:vacation, start_date: 1.day.from_now, end_date: 10.days.from_now, vacationable: Manager.first)
        expect do
          create(:vacation, start_date: 1.day.from_now, end_date: 10.days.from_now, vacationable: Manager.last)
        end.to raise_exception(ActiveRecord::RecordInvalid, 'Validation failed: Too many managers on vacation')
      end
    end
  end
end
