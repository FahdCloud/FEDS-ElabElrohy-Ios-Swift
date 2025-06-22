// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let educationCoursesModel = try? JSONDecoder().decode(EducationCoursesModel.self, from: jsonData)

import Foundation

// MARK: - EducationCoursesModel
struct EducationCoursesModel :Codable{
    var status: Int?
    var msg: String?
    var executionTimeMilliseconds: Int?
    var listSort: [ListSort]?
    var activationStatistics: ActivationStatistics?
    var pagination: Pagination?
    var educationalCoursesData: [EducationalCourseInfo]?
}
