//
// Copyright © 2020 osy. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import SwiftUI

struct VMCardView: View {
    var vm: UTMVirtualMachine
    @EnvironmentObject private var data: UTMData
    
    var body: some View {
        HStack {
            Logo(logo: nil) //FIXME: add logo support
            VStack(alignment: .leading) {
                Text(vm.configuration.name)
                    .font(.headline)
                Text(vm.configuration.systemTargetPretty)
                    .font(.subheadline)
            }.lineLimit(1)
            .truncationMode(.tail)
            Spacer()
            Button {
                data.run(vm: vm)
            } label: {
                Label("Run", systemImage: "play.circle")
                    .font(.largeTitle)
                    .foregroundColor(.accentColor)
                    .labelStyle(IconOnlyLabelStyle())
            }
        }.padding([.top, .bottom], 10)
        .buttonStyle(PlainButtonStyle())
        .contextMenu {
            Button {
                data.selectedVM = vm
            } label: {
                Label("Edit", systemImage: "slider.horizontal.3")
            }
            Button {
                data.selectedVM = vm
            } label: {
                Label("Change Logo", systemImage: "photo")
            }
            Button {
                data.selectedVM = vm
            } label: {
                Label("Run", systemImage: "play.fill")
            }
            Button {
                data.selectedVM = vm
            } label: {
                Label("Share", systemImage: "square.and.arrow.up")
            }
            Button {
                data.selectedVM = vm
            } label: {
                Label("Clone", systemImage: "doc.on.doc")
            }
            Divider()
            Button {
                data.selectedVM = vm
            } label: {
                Label("Delete", systemImage: "trash")
                    .foregroundColor(.red)
            }
        }
    }
}

#if os(macOS)
struct Logo: View {
    var logo: NSImage?
    
    var body: some View {
        Group {
            if logo != nil {
                Image(nsImage: logo!)
                    .resizable()
                    .frame(width: 30.0, height: 30.0)
                    .aspectRatio(contentMode: .fit)
            } else {
                defaultLogo
            }
        }
    }
}
#else // iOS
struct Logo: View {
    var logo: UIImage?
    
    var body: some View {
        Group {
            if logo != nil {
                Image(uiImage: logo!)
                    .resizable()
                    .frame(width: 30.0, height: 30.0)
                    .aspectRatio(contentMode: .fit)
            } else {
                defaultLogo
            }
        }
    }
}
#endif

extension Logo {
    var defaultLogo: some View {
        Image(systemName: "desktopcomputer")
            .resizable()
            .frame(width: 30.0, height: 30.0)
    }
}

struct VMCardView_Previews: PreviewProvider {
    static var previews: some View {
        VMCardView(vm: UTMVirtualMachine(configuration: UTMConfiguration(name: "Test"), withDestinationURL: URL(fileURLWithPath: "/")))
    }
}