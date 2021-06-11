//
//  ServiceIdentifier.swift
//  Astrarium
//
//  Created by Dmitry Duleba on 5/31/18.
//

import Foundation

public class ServiceIds: Hashable {

  internal let uuid = UUID()

  internal func instanciateService() -> AppService {
    fatalError("Abstract method. Should not be called directly")
  }

  // MARK: - Hashable

  public static func == (lhs: ServiceIds, rhs: ServiceIds) -> Bool {
    lhs.hashValue == rhs.hashValue
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine("\(type(of: self))")
    hasher.combine(uuid)
  }

}

public class ServiceIdentifier<T: AppService>: ServiceIds {

  internal var initBlock: (() -> T)?

  public init(initBlock: (() -> T)? = nil) {
    self.initBlock = initBlock
    super.init()
  }

  override public func instanciateService() -> AppService {
    print("Instanciating... ", terminator: "")
    debugPrint(T.self, separator: " ", terminator: "")
    if let instance = initBlock?() {
      print("... using init block")
      return instance
    }
    print("... using default init")
    return T.init()
  }

}
