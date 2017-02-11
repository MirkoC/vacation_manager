json.id vacation.id
json.start_date vacation.start_date
json.end_date vacation.end_date
json.vacation_for vacation.vacationable_type
json.vacation_for_id vacation.vacationable_id

json.manager manager, partial: 'manager/manager', as: :manager if manager
json.worker worker, partial: 'worker/worker', as: :worker if worker
