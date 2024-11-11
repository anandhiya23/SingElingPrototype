//
//  CustomTabView.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 11/11/24.
//

import SwiftUI
import UIKit

struct CustomTabView<Content: View>: UIViewControllerRepresentable {
    var pages: [Content]
    @Binding var currentPage: Int

    
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal
        )
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator
        
        // Set the initial page
        let viewControllers = [context.coordinator.controllers[currentPage]]
        pageViewController.setViewControllers(viewControllers, direction: .forward, animated: false)
      
        pageViewController.view.backgroundColor = UIColor.clear
        
        return pageViewController
    }

    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        let viewControllers = [context.coordinator.controllers[currentPage]]
        pageViewController.setViewControllers(viewControllers, direction: .forward, animated: true)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var parent: CustomTabView
        var controllers: [UIViewController]

        init(_ parent: CustomTabView) {
            self.parent = parent
//            self.controllers = parent.pages.map { UIHostingController(rootView: $0) }
            self.controllers = parent.pages.map { page in
                            let hostingController = UIHostingController(rootView: page)
                            hostingController.view.backgroundColor = UIColor.clear
                            return hostingController
                        }
        }

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            let previousIndex = index - 1
            return previousIndex >= 0 ? controllers[previousIndex] : nil
        }

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            let nextIndex = index + 1
            return nextIndex < controllers.count ? controllers[nextIndex] : nil
        }

        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            if completed, let visibleViewController = pageViewController.viewControllers?.first,
               let index = controllers.firstIndex(of: visibleViewController) {
                parent.currentPage = index
            }
        }
    }
}
