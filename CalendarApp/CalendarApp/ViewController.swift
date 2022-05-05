//
//  ViewController.swift
//  CalendarApp
//
//  Created by Nyah Campos on 5/4/22.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    
    var selectedDate = Date()
    var totalSquares = [String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setCellsView()
        setMonthView()
    }
    
    func setCellsView()
    {
        let width = (collectionView.frame.size.width - 2) / 8
        let height = (collectionView.frame.size.height - 2) / 8
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    func setMonthView()
    {
        totalSquares.removeAll()
        let daysInMonth = calendarHelper().daysInMonth(date: selectedDate)
        let firstDayOfMonth = calendarHelper().firstOfMonth(date: selectedDate)
        let startingSpaces = calendarHelper().weekDay(date: firstDayOfMonth)
        
        var count: Int = 1
        
        while (count <= 42)
        {
            if (count <= startingSpaces || count - startingSpaces > daysInMonth)
            {
                totalSquares.append("")
            }
            else
            {
                totalSquares.append(String(count - startingSpaces))
            }
            count += 1
        }
        monthLabel.text = calendarHelper().monthString(date: selectedDate) + " " + calendarHelper().yearString(date: selectedDate)
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calCell", for: indexPath) as! CalendarCell
        
        cell.dayOfMonth.text = totalSquares[indexPath.item]
        
        return cell
    }

    @IBAction func previousMonth(_ sender: Any) {
        selectedDate = calendarHelper().minusMonth(date: selectedDate)
        setMonthView()
    }
    @IBAction func nextMonth(_ sender: Any) {
        selectedDate = calendarHelper().plusMonth(date: selectedDate)
        setMonthView()
    }
    override open var shouldAutorotate: Bool
    {
        return false
    }
}

