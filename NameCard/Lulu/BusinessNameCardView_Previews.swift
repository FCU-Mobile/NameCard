//
//  BusinessNameCardView_Previews.swift
//  NameCard
//
//  Created by Lulu Liao on 2025/9/10.
//

import SwiftUI

struct BusinessNameCardView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessNameCardView(
            name: Contact.meiwataData.fullName,
            title: Contact.meiwataData.title,
            phone: Contact.meiwataData.phone,
            email: Contact.meiwataData.email,
            company: Contact.meiwataData.organization,
            logo: Image(systemName: "building.2.fill")
        )
    }
}
