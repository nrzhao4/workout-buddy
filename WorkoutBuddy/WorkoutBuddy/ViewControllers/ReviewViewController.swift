//
//  ReviewViewController.swift
//  WorkoutBuddy
//
//  Created by Pluto on 2019-10-17.
//  Copyright © 2019 Nina Zhao. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController, WorkoutDelegate {
    
    let CELL_ID = "CELL_ID"

    @IBOutlet weak var reviewTable: UITableView!
    
    var workout = [WorkoutUserInput]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewTable.delegate = self
        reviewTable.dataSource = self
    }
    
    func workoutData(workoutExercises: [WorkoutUserInput]) {
        workout = workoutExercises
    }

}

extension ReviewViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workout.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let exercise = workout[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! ExerciseTableViewCell
        cell.setUpCell(exercise: exercise)
        return cell
    }
}
