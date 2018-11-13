#pragma once

#include <include/profiler/event.hpp>
#include <include/profiler/i-observer.hpp>


enum class IViewType { source, line, leak, error };


// This is an inteface class
class IView : public IObserver
{
    public:
        IView() = default;
        virtual ~IView() = default;

        virtual void update(const Event& event) = 0;
};