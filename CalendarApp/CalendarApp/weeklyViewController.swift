//
//  weeklyViewController.swift
//  CalendarApp
//
//  Created by Nyah Campos on 5/4/22.
//

import Foundation
import UIKit

var selectedDate = Date()

class weeklyViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    
    
    var selectedDate = Date()
    var totalSquares = [Date]()
    
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
        var current = calendarHelper().sundayforDate(date: selectedDate)
        let nextSunday = calendarHelper().addDays(date: current, days: 7)
        
        while (current < nextSunday)
        {
            totalSquares.append(current)
            current = calendarHelper().addDays(date: current, days: 7)
        }
        monthLabel.text = calendarHelper().monthString(date: selectedDate) + " " + calendarHelper().yearString(date: selectedDate)
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calCell", for: indexPath) as! CalendarCell
        
        let date = totalSquares[indexPath.item]
        cell.dayOfMonth.text = String(calendarHelper().dayOfMonth(date: date))
        
        if (date == selectedDate)
        {
            cell.backgroundColor = UIColor.systemMint
        }
        else
        {
            cell.backgroundColor = UIColor.white
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDate = totalSquares[indexPath.item]
        collectionView.reloadData()
    }

    @IBAction func previousWeek(_ sender: Any) {
        selectedDate = calendarHelper().addDays(date: selectedDate, days: -7)
        setMonthView()
    }
    @IBAction func nextWeek(_ sender: Any) {
        selectedDate = calendarHelper().addDays(date: selectedDate, days: 7)
        setMonthView()
    }
    override open var shouldAutorotate: Bool
    {
        return false
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Event().eventsForDate(date: selectedDate).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID")!
        return cell
    }
}


