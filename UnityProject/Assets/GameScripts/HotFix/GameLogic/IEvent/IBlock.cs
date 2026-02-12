using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

public interface IBlock
{
    void onMouseDown();
    void onMouseDrag();
    void onMouseUp();
    void Match();
    void Remove();
    void Function();
}

