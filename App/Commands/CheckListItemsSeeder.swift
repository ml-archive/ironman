import Console

public final class CheckListItemsSeeder: Command {
    public let id = "seeder:checklist"

    public let help: [String] = [
            "Seeds the database with checlist items"
    ]

    public let console: ConsoleProtocol

    public init(console: ConsoleProtocol) {
        self.console = console
    }

    public func run(arguments: [String]) throws {

        console.info("Started the seeder for checlist");

        let checklistItems = [
                try CheckListItem(node: [
                        "race_id": "1",
                        "type": "registration",
                        "title": "Valid triathlon license",
                        "position": "0",
                        "is_active": "1",
                        "created_at": "2014-06-02 11:01:58",
                        "updated_at": "2014-06-02 11:01:58"
                ]),
                try CheckListItem(node: [
                        "race_id": "1",
                        "type": "registration",
                        "title": "Valid picture ID",
                        "position": "1",
                        "is_active": "1",
                        "created_at": "2014-06-02 11:02:04",
                        "updated_at": "2014-06-02 11:02:04"
                ]),
                try CheckListItem(node: [
                        "race_id": "1",
                        "type": "check_in",
                        "title": "Bike",
                        "position": "0",
                        "is_active": "1",
                        "created_at": "2014-06-02 11:02:24",
                        "updated_at": "2014-06-02 11:02:24"
                ]),
                try CheckListItem(node: [
                        "race_id": "1",
                        "type": "check_in",
                        "title": "Helmet",
                        "position": "1",
                        "is_active": "1",
                        "created_at": "2014-06-02 11:02:30",
                        "updated_at": "2014-06-02 11:02:30"
                ]),
                try CheckListItem(node: [
                        "race_id": "1",
                        "type": "check_in",
                        "title": "BLUE bike bag",
                        "position": "2",
                        "is_active": "1",
                        "created_at": "2014-06-02 11:02:36",
                        "updated_at": "2014-06-02 11:02:36"
                ]),
        ];

        checklistItems.forEach({
            var checklistItem = $0
            console.info("Looping \(checklistItem.title)")
            do {
                try checklistItem.save()
            } catch {
                console.error("Failed to store \(checklistItem.title)")
                print(error)
            }
        })


        console.info("Finished the seeder for rss");
    }
}
