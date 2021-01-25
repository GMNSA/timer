#ifndef STOPWATCH_HPP
#define STOPWATCH_HPP

#include <QObject>
#include <QTime>

class StopWatch :
        public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString display READ display WRITE setDisplay NOTIFY displayChanged)
public:
    explicit StopWatch(QObject *parent = nullptr);
    Q_DISABLE_COPY(StopWatch);
    virtual ~StopWatch();

    static void registerMe(QString const &aText);

    // QObject interface
protected:
    virtual void timerEvent(QTimerEvent *event) override;

signals:
    void triggerTime(QString const &aText);
    void displayChanged();

public slots:
    void start();
    void stop();
    void reset();


    // private
private:
    QTime *m_timer;
    bool   m_isRun;

    QString display();
    void setDisplay(QString &aText);
    void timeout();
};

#endif // STOPWATCH_HPP
