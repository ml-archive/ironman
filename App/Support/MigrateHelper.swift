import Vapor

struct MigrateHelper {
    static func oldRaceIdToNew(oldRaceId: Int) throws -> Int{
        switch(oldRaceId) {
        case 26:
            return 1;
        case 31:
            return 2;
        case 33:
            return 3;
        default:
            throw Abort.custom(status: .badRequest, message: "raceId could not be converted")
        }
    }
}
