SuckerPunch.config do
  queue name: :create_queue, worker: CreateWorker, workers: 2
  #queue name: :update_queue, worker: UpdateWorker, workers: 2
  #queue name: :delete_queue, worker: DeleteWorker, workers: 2
end