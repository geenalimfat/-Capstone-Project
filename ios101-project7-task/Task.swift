//
//  Task.swift
//

import UIKit

// The Task model
struct Task {

    // The task's title
    var title: String

    // An optional note
    var note: String?

    // The due date by which the task should be completed
    var dueDate: Date

    // Initialize a new task
    // `note` and `dueDate` properties have default values provided if none are passed into the init by the caller.
//    init(title: String, note: String? = nil, dueDate: Date = Date()) {
    init(id: String, title: String, note: String? = nil, dueDate: Date = Date()) {
        self.id = id
        self.title = title
        self.note = note
        self.dueDate = dueDate
    }

    // A boolean to determine if the task has been completed. Defaults to `false`
    var isComplete: Bool = false {

        // Any time a task is completed, update the completedDate accordingly.
        didSet {
            if isComplete {
                // The task has just been marked complete, set the completed date to "right now".
                completedDate = Date()
            } else {
                completedDate = nil
            }
        }
    }

    // The date the task was completed
    // private(set) means this property can only be set from within this struct, but read from anywhere (i.e. public)
    private(set) var completedDate: Date?

    // The date the task was created
    // This property is set as the current date whenever the task is initially created.
    let createdDate: Date = Date()

    // An id (Universal Unique Identifier) used to identify a task.
//    let id: String = UUID().uuidString
    let id: String
}

//extension Task: Codable {
//
//    enum CodingKeys: String, CodingKey {
//        case title, note, dueDate, isComplete, completedDate
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        title = try container.decode(String.self, forKey: .title)
//        note = try container.decodeIfPresent(String.self, forKey: .note)
//        dueDate = try container.decode(Date.self, forKey: .dueDate)
//        isComplete = try container.decode(Bool.self, forKey: .isComplete)
//        completedDate = try container.decodeIfPresent(Date.self, forKey: .completedDate)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(title, forKey: .title)
//        try container.encode(note, forKey: .note)
//        try container.encode(dueDate, forKey: .dueDate)
//        try container.encode(isComplete, forKey: .isComplete)
//        try container.encodeIfPresent(completedDate, forKey: .completedDate)
//    }
//}
extension Task: Codable {

    enum CodingKeys: String, CodingKey {
        case id, title, note, dueDate, isComplete, completedDate
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        note = try container.decodeIfPresent(String.self, forKey: .note)
        dueDate = try container.decode(Date.self, forKey: .dueDate)
        isComplete = try container.decode(Bool.self, forKey: .isComplete)
        completedDate = try container.decodeIfPresent(Date.self, forKey: .completedDate)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(note, forKey: .note)
        try container.encode(dueDate, forKey: .dueDate)
        try container.encode(isComplete, forKey: .isComplete)
        try container.encodeIfPresent(completedDate, forKey: .completedDate)
    }
}

// MARK: - Task + UserDefaults
extension Task {
    private static let tasksKey = "tasks"

    // Given an array of tasks, encodes them to data and saves to UserDefaults.
    static func save(_ tasks: [Task]) {
        do {
            // Encode the array of tasks to data using a JSONEncoder instance
            let encoder = JSONEncoder()
            let encodedTasks = try encoder.encode(tasks)
            // Save the encoded tasks data to UserDefaults with a key
            UserDefaults.standard.set(encodedTasks, forKey: tasksKey)
        } catch {
            print("Error encoding tasks: \(error.localizedDescription)")
        }
        // TODO: Save the array of tasks
    }

    // Retrieve an array of saved tasks from UserDefaults.
    static func getTasks() -> [Task] {
        // TODO: Get the array of saved tasks from UserDefaults
        guard let savedTasksData = UserDefaults.standard.data(forKey: tasksKey) else {
            return []
        }
        do {
            // Decode the tasks data into an array of Task objects
            let decoder = JSONDecoder()
            let tasks = try decoder.decode([Task].self, from: savedTasksData)
            return tasks
        } catch {
            print("Error decoding tasks: \(error.localizedDescription)")
            return []
        }
//        return [] // 👈 replace with returned saved tasks
    }

    // Add a new task or update an existing task with the current task.
    func save() {
    //    var tasks = Task.getTasks()
    //            if let existingTaskIndex = tasks.firstIndex(where: { $0.id == self.id }) {
    //                // Update existing task
    //                tasks.remove(at: existingTaskIndex)
    //                tasks.insert(self, at: existingTaskIndex)
    //            } else {
    //                // Add new task
    //                tasks.append(self)
    //            }
    //            // Save the updated tasks array to UserDefaults
    //            Task.save(tasks)
//        var tasks = Task.getTasks()
//            if let existingTaskIndex = tasks.firstIndex(where: { $0.id == self.id }) {
//                // Check if the task completion status has changed
//                if tasks[existingTaskIndex].isComplete != self.isComplete {
//                    // Task completion status has changed, remove existing task
//                    tasks.remove(at: existingTaskIndex)
//                    if !self.isComplete {
//                        // Task is incomplete, insert at the beginning of the array
//                        tasks.insert(self, at: 0)
//                    } else {
//                        // Task is completed, append to the end of the array
//                        tasks.append(self)
//                    }
//                } else {
//                    // Update existing task
//                    tasks[existingTaskIndex] = self
//                }
//            } else {
//                // Add new task
//                tasks.append(self)
//            }
//            // Save the updated tasks array to UserDefaults
//        Task.save(tasks)
        // TODO: Save the current task
//        
//        var tasks = Task.getTasks()
//            if let existingTaskIndex = tasks.firstIndex(where: { $0.id == self.id }) {
//                // Update existing task
//                tasks[existingTaskIndex].isComplete = self.isComplete
//                if self.isComplete {
//                    // If the task is marked as completed, update its completedDate
//                    tasks[existingTaskIndex].completedDate = Date()
//                } else {
//                    // If the task is marked as incomplete, clear its completedDate
//                    tasks[existingTaskIndex].completedDate = nil
//                }
//            } else {
//                // Add new task
//                tasks.append(self)
//            }
//            // Save the updated tasks array to UserDefaults
//            Task.save(tasks)
        
        var tasks = Task.getTasks()
            if let existingTaskIndex = tasks.firstIndex(where: { $0.id == self.id }) {
                // Update existing task
                tasks[existingTaskIndex] = self
            } else {
                // Add new task
                tasks.append(self)
            }
            // Save the updated tasks array to UserDefaults
            Task.save(tasks)
    }
}
