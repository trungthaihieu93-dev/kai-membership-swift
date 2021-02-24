//
//  ServicesRepository.swift
//  KAI Membership
//
//  Created by Anh Kiệt on 23/02/2021.
//

import Alamofire
import RealmSwift

protocol URLContructable {
    var domain: String { get }
    var path: String { get }
}

protocol APIInputBase: URLContructable {
    var path: String { get }
    var headers: HTTPHeaders { get }
    var params: Parameters { get }
    var method: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
    var data: Data? { get }
    var returnErrorData: Bool { get }
}

protocol APIOutputBase: class {
    init(response: AFDataResponse<Any>)
    var output: APIResult<Data, APIServiceError> { get }
}

enum APIResult<T, E> {
    case success(T)
    case failure(E)
}

enum APIServiceError: Error {
    case network(String)
    case message(String)
}

class APIInput: APIInputBase {
    
    let domain: String
    let path: String
    
    var headers: HTTPHeaders = [
        HTTPHeader(name: "Content-Type", value: "application/json"),
        HTTPHeader(name: "accept", value: "application/json"),
        HTTPHeader(name: "language", value: "vi-vn"),
        HTTPHeader(name: "platform", value: "ios"),
        HTTPHeader(name: "app_version", value: Constants.appVersion),
        HTTPHeader(name: "os_version", value: Constants.Device.version),
        HTTPHeader(name: "device_id", value: Constants.Device.id),
        HTTPHeader(name: "device_name", value: Constants.Device.name),
        HTTPHeader(name: "device_model", value: Constants.Device.model),
    ]
    
    var params: Parameters = [:]
    var method: HTTPMethod = .get
    var encoding: ParameterEncoding = URLEncoding.default
    var data: Data?
    var returnErrorData: Bool = false
    
    init(withDomain domain: String, path: String = "", params: Parameters = [:], method: HTTPMethod = .get) {
        self.domain = domain
        self.path = path
        self.params = params
        self.method = method
        self.encoding = (method == .get || method == .delete) ? URLEncoding.default : JSONEncoding.default
    }
}

class APIOutput: APIOutputBase {
    
    var response: AFDataResponse<Any>
    
    required init(response: AFDataResponse<Any>) {
        self.response = response
    }
    
    var output: APIResult<Data, APIServiceError> {
        switch response.result {
        case .success(let data):
            if let records = response.data {
                return .success(records)
            } else {
                return .failure(.message("ERROR"))
            }
        case .failure(let error):
            return .failure(.network(error.localizedDescription))
        }
    }
}

extension URLContructable where Self: APIInputBase {
    
    var url: String {
        return domain + path
    }
}

struct ErrorResult: Error, Codable {
    
    var code: String?
    var message: String = "Error"
    
    enum CodingKeys: String, CodingKey {
        case code
        case message
    }
    
    init(with code: String? = nil, message: String) {
        self.code = code
        self.message = message
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        code = try container.decodeIfPresent(String.self, forKey: .code)
        message = try container.decodeIfPresent(String.self, forKey: .message) ?? "Error"
    }
}

class APIServices {
    
    class func request<T: APIOutputBase>(input: APIInputBase, output: T.Type, _ completion: @escaping (T) -> Void) {
        AF.request(input.url, method: input.method, parameters: input.params, encoding: input.encoding, headers: input.headers).responseJSON(queue: .main) { response in
            completion(T(response: response))
        }
    }
}

class RealmServices {
    
    private init() {
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
    }
    
    static let shared = RealmServices()
    
    private let config = Realm.Configuration(
        // Set the new schema version. This must be greater than the previously used
        // version (if you've never set a schema version before, the version is 0).
        schemaVersion: 1,
        // Set the block which will be called automatically when opening a Realm with
        // a schema version lower than the one set above
        migrationBlock: { migration, oldSchemaVersion in
            // We haven’t migrated anything yet, so oldSchemaVersion == 0
            if (oldSchemaVersion < 1) {
                // Nothing to do!
                // Realm will automatically detect new properties and removed properties
                // And will update the schema on disk automatically
            }
        }
    )
    
    func get<T: RealmSwift.Object, KeyType>(ofType type: T.Type, forPrimaryKey key: KeyType) -> T? {
        let realm = try? Realm()

        return realm?.object(ofType: type, forPrimaryKey: key)
    }
    
    func getAll<T: RealmSwift.Object>(ofType type: T.Type, ofPredicate predicateString: String? = nil) -> [T] {
        let realm = try? Realm()

        if let filter = predicateString {
            if let result = realm?.objects(type).filter(filter) {
                return Array(result)
            } else {
                return []
            }
        } else {
            if let result = realm?.objects(type) {
                return Array(result)
            } else {
                return []
            }
        }
    }
    
    func create<T: RealmSwift.Object>(_ object: T) {
        let realm = try? Realm()
        
        do {
            try realm?.write {
                realm?.add(object, update: .all)
            }
        } catch {
            post(error)
        }
    }
    
    func create<T: RealmSwift.Object>(_ objects: [T]) {
        let realm = try? Realm()
        
        do {
            try realm?.write {
                realm?.add(objects, update: .all)
            }
        } catch {
            post(error)
        }
    }
    
    func delete<T: RealmSwift.Object>(ofType type: T.Type, with uuid: String) {
        let realm = try? Realm()
        
        do {
            try realm?.write {
                let predicate = NSPredicate(format: "uuid == %@", uuid)
                
                if let objDelete = realm?.objects(type).filter(predicate).first {
                    realm?.delete(objDelete)
                }
            }
        } catch {
            post(error)
        }
    }
    
    func deleteAll() {
        let realm = try? Realm()
        
        do {
            try realm?.write {
                realm?.deleteAll()
            }
        } catch {
            post(error)
        }
    }
    
    func post(_ error: Error) {
        NotificationCenter.default.post(name: Notification.Name("RealmError"), object: error)
    }
}
