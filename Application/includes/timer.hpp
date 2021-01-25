#ifndef TIMER_HPP
#define TIMER_HPP

#include <QObject>
#include <QTime>
#include <QTimer>
#include <QQmlEngine>
#include <QSound>

// TO DO round to fill

class Timer :
        public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString display READ display WRITE setDisplay NOTIFY changeDisplay)
    Q_PROPERTY(int seconds READ seconds WRITE setSeconds);
    Q_PROPERTY(int procentRound READ procentRound NOTIFY changeProcent)
public:
    Timer(QObject *parent = nullptr);
    virtual ~Timer();

    static void registerMe(QString const &aText);

    Q_INVOKABLE int maxRound();
    // QObject interface
protected:
    virtual void timerEvent(QTimerEvent *event) override;

signals:
    void changeDisplay();
    void calculateTime();
    void triggerTimer();
    void changeProcent();
    // void setDisplay(QString const &aText);

public slots:
    QString display();
    void    setDisplay(QString const &aText);
    int32_t seconds();
    void    setSeconds(int32_t aSeconds);
    void    remove();
    void    start();
    void    stop();
    void    pause();
    void    timeout();
    bool    isCheckedButton();
    int     procentRound();

private:
    QString m_numbers;
    QTime  *m_timer;
    QString m_resultRunTimer;
    int32_t m_pauseSec;

    bool    m_isRun;
    QString m_result;
    QTimer  *m_tim;
    int32_t m_seconds;
    int32_t m_maxLimitSecond;

    // private meethods

    int32_t calculateSec(QString const &aTime);
    QString calculateTime(QString const &aNum);
    void setDisplayTime(QString const &aText);
    bool checked();

};

#endif // TIMER_HPP
