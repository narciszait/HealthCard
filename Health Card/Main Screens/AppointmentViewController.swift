//
//  AppointmentViewController.swift
//  Health Card
//
//  Created by Narcis Zait on 06/04/2018.
//  Copyright © 2018 Narcis Zait. All rights reserved.
//

import UIKit

class AppointmentViewController: UIViewController, JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    @IBOutlet weak var calendarView: JTAppleCalendarView!;
    @IBOutlet weak var year: UILabel!;
    @IBOutlet weak var month: UILabel!;
    
    let formatter = DateFormatter();
    
    let outsideMonthColor = UIColor(colorWithHexValue: 0xCB9A13);
    let monthColor = UIColor.white // UIColor.black;
    let selectedMonthColor = UIColor(colorWithHexValue: 0xFFC115); // UIColor.white; // UIColor(colorWithHexValue: 0xff0000);
    let currentDateSelectedViewColor = UIColor(colorWithHexValue: 0x4e3f5d);
    
    override func viewDidLoad() {
        super.viewDidLoad();
        setupCalendar();
    }
    
    func setupCalendar(){
        calendarView.minimumLineSpacing = 0;
        calendarView.minimumInteritemSpacing = 0;
        
        calendarView.visibleDates { (visibleDates) in
            self.setupViewsOfCalendar(from: visibleDates);
        }
        
        calendarView.scrollToDate(Date(), animateScroll: true);
//        calendarView.selectDates([ Date() ]);
    }
    
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo){
        let date = visibleDates.monthDates.first!.date;
        
        formatter.dateFormat = "yyyy";
        year.text = formatter.string(from: date);
        
        formatter.dateFormat = "MMMM";
        month.text = formatter.string(from: date);
    }
    
    func handleCellSelected(view: JTAppleCell?, cellState: CellState){
        guard let validCell = view as? CustomCalendarCell else { return };
        
        if cellState.isSelected {
            validCell.selectedView.isHidden = false;
        } else {
            validCell.selectedView.isHidden = true;
        }
    }
    
    func handleCellTextColor(view: JTAppleCell?, cellState: CellState){
        guard let validCell = view as? CustomCalendarCell else { return };
        
        if cellState.isSelected {
                validCell.dateLabel.textColor = selectedMonthColor;
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                validCell.dateLabel.textColor = monthColor;
            } else {
                validCell.dateLabel.textColor =  outsideMonthColor;
            }
        }
    }
    
    func handleCellVisibility(view: JTAppleCell?, cellState: CellState){
        guard let validCell = view as? CustomCalendarCell else { return };
        validCell.isHidden = cellState.dateBelongsTo == .thisMonth ? false : true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        // Dispose of any resources that can be recreated.
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd";
        formatter.timeZone = Calendar.current.timeZone;
        formatter.locale = Calendar.current.locale;
        
        let startDate = formatter.date(from: "2018 01 01")!;
        let endDate = formatter.date(from: "2018 12 31")!;
        var parameters = ConfigurationParameters(startDate: startDate, endDate: endDate);
        parameters.firstDayOfWeek = DaysOfWeek.monday;
        return parameters;
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCalendarCell", for: indexPath) as! CustomCalendarCell;
        cell.dateLabel.text = cellState.text;
        
        handleCellSelected(view: cell, cellState: cellState);
        handleCellTextColor(view: cell, cellState: cellState);
        handleCellVisibility(view: cell, cellState: cellState);
        
        return cell;
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard let validCell = cell as? CustomCalendarCell else { return };
        handleCellSelected(view: cell, cellState: cellState);
        handleCellTextColor(view: cell, cellState: cellState);
        
        let alertController = UIAlertController(title: "Appointment", message: "We are sorry, but we are fully booked on that day. \n Please select another day", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil);
        alertController.addAction(okAction);
        self.present(alertController, animated: true) {
            self.calendarView.deselectAllDates();
            validCell.selectedView.isHidden = true;
        }
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState);
        handleCellTextColor(view: cell, cellState: cellState);
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        return
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViewsOfCalendar(from: visibleDates);
    }
    
    @IBAction func logoutFromCalendar(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "firstLoginSuccessful");
        UserDefaults.standard.set("", forKey: "citizenCPR");
        self.performSegue(withIdentifier: "backToMainFromCalendar", sender: self);
    }
    
}
